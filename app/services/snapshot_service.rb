class SnapshotService
  def create_campaign_snapshot(profile)
    create_snapshot(profile, 'spCampaign')
  end

  def create_ad_group_snapshot(profile)
    create_snapshot(profile, 'spAdGroup')
  end

  def create_keyword_snapshot(profile)
    create_snapshot(profile, 'spKeyword')
  end

  def create_target_snapshot(profile)
    create_snapshot(profile, 'spTarget')
  end

  def update_snapshot_status(snapshot)
    ad_service = AmazonAdvertisingService.new(snapshot.profile.api_account, snapshot.profile.marketplace.region, snapshot.profile)
    response = ad_service.get("/v2/snapshots/#{snapshot.snapshot_external_id}")
    snapshot_status = response['status']
    snapshot.update!(status: snapshot_status)
    snapshot_status
  end

  def retrieve_snapshot_data(snapshot)
    ad_service = AmazonAdvertisingService.new(snapshot.profile.api_account, snapshot.profile.marketplace.region, snapshot.profile)
    ad_service.get("/v2/snapshots/#{snapshot.snapshot_external_id}/download")
  end

  def process_snapshot_data(snapshot, data, data_retrieved_at)
    case snapshot.snapshot_type
    when 'spCampaign'
      process_campaign_data(snapshot.profile, data, data_retrieved_at)
    when 'spAdGroup'
      process_ad_group_data(snapshot.profile, data, data_retrieved_at)
    when 'spKeyword'
      process_keyword_data(snapshot.profile, data, data_retrieved_at)
    when 'spTarget'
      process_target_data(snapshot.profile, data, data_retrieved_at)
    end

    snapshot.update(status: 'PROCESSED')
  end

  private

  def create_snapshot(profile, snapshot_type)
    pluralized_type = snapshot_type.delete_prefix('sp').sub(/^(.)/) { $1.downcase }.pluralize
    response = AmazonAdvertisingService.new(profile.api_account, profile.marketplace.region, profile).post("/v2/sp/#{pluralized_type}/snapshot")
    snapshot_id = response['snapshotId']
    save_snapshot_record(profile, snapshot_id, snapshot_type)
  end

  def save_snapshot_record(profile, snapshot_id, snapshot_type)
    Snapshot.create(snapshot_external_id: snapshot_id, snapshot_type: snapshot_type, status: 'IN_PROGRESS', profile: profile)
  end

  def load_snapshot_data(snapshot)
    snapshot_data = get_snapshot_data(snapshot.snapshot_external_id)
    process_snapshot_data(snapshot, snapshot_data) if snapshot_data.present?
  end

  def process_campaign_data(profile, data, data_retrieved_at)
    data.each do |campaign_data|
      campaign = Campaign.find_or_initialize_by(campaign_external_id: campaign_data['campaignId'])
  
      campaign.assign_attributes(
        profile: profile,
        last_retrieved_at: data_retrieved_at,
        name: campaign_data['name'],
        campaign_external_id: campaign_data['campaignId'].to_s,
        campaign_type: campaign_data['campaignType'],
        targeting_type: campaign_data['targetingType'],
        premium_bid_adjustment: campaign_data['premiumBidAdjustment'],
        daily_budget: campaign_data['dailyBudget'],
        start_date: Date.parse(campaign_data['startDate']), # Parse the date string if necessary
        state: campaign_data['state'],
        bidding_strategy: campaign_data['bidding']['strategy'],
      )
  
      campaign.save!
    end
  end

  def process_ad_group_data(profile, data, data_retrieved_at)
    data.each do |ad_group_data|
      campaign = Campaign.find_or_create_by(campaign_external_id: ad_group_data['campaignId'].to_s, profile: profile)
      ad_group = AdGroup.find_or_initialize_by(ad_group_external_id: ad_group_data['adGroupId'], campaign: campaign)
  
      ad_group.assign_attributes(
        last_retrieved_at: data_retrieved_at,
        name: ad_group_data['name'],
        ad_group_external_id: ad_group_data['adGroupId'].to_s,
        default_bid: ad_group_data['defaultBid'],
        state: ad_group_data['state'],
        campaign: campaign,
      )
  
      ad_group.save!
    end
  end
  
  def process_keyword_data(profile, data, data_retrieved_at)
    data.each do |keyword_data|
      campaign = Campaign.find_or_create_by(campaign_external_id: keyword_data['campaignId'].to_s, profile: profile)
      ad_group = AdGroup.find_or_create_by(ad_group_external_id: keyword_data['adGroupId'], campaign: campaign)
      keyword = Keyword.find_or_initialize_by(keyword_external_id: keyword_data['keywordId'], ad_group: ad_group)
  
      keyword.assign_attributes(
        last_retrieved_at: data_retrieved_at,
        keyword_text: keyword_data['keywordText'],
        keyword_external_id: keyword_data['keywordId'].to_s,
        match_type: keyword_data['matchType'],
        state: keyword_data['state'],
        bid: keyword_data['bid'],
        ad_group: ad_group,
      )
  
      keyword.save!
    end
  end
  
  def process_target_data(profile, data, data_retrieved_at)
    data.each do |target_data|
      campaign = Campaign.find_or_create_by(campaign_external_id: target_data['campaignId'].to_s, profile: profile)
      ad_group = AdGroup.find_or_create_by(ad_group_external_id: target_data['adGroupId'].to_s, campaign: campaign)
      product_targeting = ProductTargeting.find_or_initialize_by(product_targeting_external_id: target_data['targetId'], ad_group: ad_group)
  
      product_targeting.assign_attributes(
        last_retrieved_at: data_retrieved_at,
        expression_type: target_data['expressionType'],
        product_targeting_external_id: target_data['targetId'].to_s,
        state: target_data['state'],
        bid: target_data['bid'],
        ad_group: ad_group,
      )
  
      product_targeting.save!
    end
  end
  
end
  
   
