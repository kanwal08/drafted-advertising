class Snapshot::CreateSnapshotWorker
  include Sidekiq::Worker

  def perform(profile_id, snapshot_type)
    profile = Profile.find(profile_id)

    snapshot_service = SnapshotService.new
    
    case snapshot_type
    when 'spCampaign'
      snapshot_service.create_campaign_snapshot(profile)
    when 'spAdGroup'
      snapshot_service.create_ad_group_snapshot(profile)
    when 'spKeyword'
      snapshot_service.create_keyword_snapshot(profile)
    when 'spTarget'
      snapshot_service.create_target_snapshot(profile)
    end
  end
end
