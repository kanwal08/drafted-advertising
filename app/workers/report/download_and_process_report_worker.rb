class Report::DownloadAndProcessReportWorker
  include Sidekiq::Worker

  def perform(report_id)
    report = Report.find(report_id)
    report.update!(status: 'PROCESSING')
    ReportService.new.download_and_process_report(report)
    report.update!(status: 'PROCESSED')

    (report.start_date..report.end_date).each do |date|
      Summary::UpdateProfileMetricSummariesWorker.perform_async(report.profile.id, date.to_s)
    end
  end
end
