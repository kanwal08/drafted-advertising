class ProfileService
  def initialize(api_account, region)
    @api_account = api_account
    @region = region
    @existing_profile_ids = @api_account.profiles.pluck(:id)
    @advertising_service = AmazonAdvertisingService.new(api_account, region)
  end

  def update_profiles
    response = @advertising_service.get('/v2/profiles')
    save_profiles(response)
    # After updating the profiles, set inactive_at for profiles not present in the response
    mark_missing_profiles_inactive
  end

  private

  def save_profiles(profiles)
    profiles.each do |profile|
      marketplace = get_marketplace(profile)
      next if marketplace.blank?

      new_profile = create_or_update_profile(profile, marketplace)
      next if new_profile.blank?

      account = create_or_update_account(profile['accountInfo'])

      new_profile.account = account
      new_profile.save!

      # If the profile was in the response, remove it from the existing profile ids list
      @existing_profile_ids.delete(new_profile.id)
    end
  end

  def create_or_update_profile(profile, marketplace)
    new_profile = Profile.find_or_initialize_by(profile_external_id: profile['profileId'])
    if new_profile.persisted?
      # If the profile exists, update the inactive_at field to nil
      new_profile.update!(inactive_at: nil)
    else
      new_profile.inactive_at = nil # This line is optional, as new records will have inactive_at=nil by default
      new_profile.api_account = @api_account
      new_profile.marketplace = marketplace
    end

    new_profile
  end

  def mark_missing_profiles_inactive
    # For any profiles that weren't present in the response, set their inactive_at
    Profile.where(id: @existing_profile_ids).update_all(inactive_at: Time.zone.now)
  end

  def create_or_update_account(account_info)
    account = Account.find_or_initialize_by(external_id: account_info['id'])
    if account.new_record?
      account.name = account_info['name']
      account.account_type = account_info['type']
      account.region = @region
      account.save!
    end

    account
  end

  def get_marketplace(market)
    Marketplace.find_by(country_code: market['countryCode'])
  end
  
end
