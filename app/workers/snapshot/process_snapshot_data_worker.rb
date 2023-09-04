class Snapshot::ProcessSnapshotDataWorker
  include Sidekiq::Worker

  def perform(snapshot_id, data_retrieved_at)
    snapshot = Snapshot.find(snapshot_id)
    return if snapshot.status == 'PROCESSED'

    snapshot.update!(status: 'PROCESSING')
    snapshot_service = SnapshotService.new
    snapshot_data = snapshot_service.retrieve_snapshot_data(snapshot)
    snapshot_service.process_snapshot_data(snapshot, snapshot_data, data_retrieved_at) if snapshot_data.present?
  end
end