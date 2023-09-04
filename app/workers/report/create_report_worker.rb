class Report::CreateReportWorker
  include Sidekiq::Worker

  def perform(profile_id, start_date, end_date)
    profile = Profile.find(profile_id)
    report_service = ReportService.new

    # Create report
    report_service.create_report(profile, start_date, end_date)
  end
end