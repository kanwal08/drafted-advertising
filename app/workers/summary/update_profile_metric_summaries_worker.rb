class Summary::UpdateProfileMetricSummariesWorker

  include Sidekiq::Worker

  def perform(profile_id, date)
    profile = Profile.find(profile_id)
    SummaryService.new.update_profile_metric_summaries(profile, date)
  end

end
