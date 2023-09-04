class Snapshot::CheckSnapshotStatusWorker
  include Sidekiq::Worker

  def perform(snapshot_id)
    snapshot = Snapshot.find(snapshot_id)
    return if snapshot.status in ['PROCESSED', 'PROCESSING', 'QUEUED FOR PROCESSING']

    snapshot_service = SnapshotService.new
    snapshot_status = snapshot_service.update_snapshot_status(snapshot)
    
    if snapshot_status == 'SUCCESS'
      data_retrieved_at = Time.now.utc
      Snapshot::ProcessSnapshotDataWorker.perform_async(snapshot.id, data_retrieved_at.to_s)
      snapshot.update!(status: 'QUEUED FOR PROCESSING')
    end
  end
end