class ProfileUpdateWorker
    include Sidekiq::Worker

    def perform(api_account_id, region_id)
      api_account = ApiAccount.find(api_account_id)
      region = Region.find(region_id)
      profile_service = ProfileService.new(api_account, region)   
      profile_service.update_profiles

    rescue ActiveRecord::RecordNotFound
        # handle not found error, perhaps log it
    end
end