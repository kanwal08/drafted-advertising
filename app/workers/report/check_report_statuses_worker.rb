class Report::CheckReportStatusesWorker
  include Sidekiq::Worker

  def perform(report_id)
    report = Report.find(report_id)
    return if report.status in ['PROCESSED', 'PROCESSING', 'QUEUED FOR PROCESSING', 'FAILED']
    
    status = ReportService.new.update_report_status(report)

    if status == 'COMPLETED'
      Report::DownloadAndProcessReportWorker.perform_async(report.id)
      report.update!(status: 'QUEUED FOR PROCESSING')
    end
  end
end
