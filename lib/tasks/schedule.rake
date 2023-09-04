namespace :schedule do

  desc 'Update profiles for each ApiAccount and Region'
  task update_profiles: :environment do
    ApiAccount.find_each do |api_account|
      Region.find_each do |region|
        ProfileUpdateWorker.perform_async(api_account.id, region.id)
      end
    end
  end

  desc "Enqueue Sidekiq jobs to check pending snapshot and report statuses"
  task check_pending_snapshot_and_report_statuses: :environment do
    Snapshot.where(status: 'IN_PROGRESS').each do |snapshot|
      Snapshot::CheckSnapshotStatusWorker.perform_async(snapshot.id)
    end

    Report.where(status: 'PENDING').each do |report|
      Report::CheckReportStatusesWorker.perform_async(report.id)
    end
  end

  desc "Enqueue Sidekiq jobs to create 30-day reports and snapshots for active profiles" 
  task create_reports_30_day_and_snapshots: :environment do
    current_date = Date.today
    start_date = current_date - 30.days
    end_date = current_date

    # Snapshots
    Snapshot::CreateSnapshotWorker.perform_async(profile.id, 'spCampaign')
    Snapshot::CreateSnapshotWorker.perform_async(profile.id, 'spAdGroup')
    Snapshot::CreateSnapshotWorker.perform_async(profile.id, 'spKeyword')
    Snapshot::CreateSnapshotWorker.perform_async(profile.id, 'spTarget')

    # Reports
    Profile.where(is_actively_managed: true).each do |profile|
      if profile.reports.empty?
        # Grab extra data if this is the first time running reports for this profile. Reports can span a maximum of 30 days.
        Report::CreateReportWorker.perform_async(profile.id, (current_date-61.days).to_s, (current_date - 31.day).to_s)
      end

      Report::CreateReportWorker.perform_async(profile.id, start_date.to_s, end_date.to_s)
    end
  end

  desc "Enqueue Sidekiq jobs to create 3-day reports and snapshots for active profiles" 
  task create_reports_and_snapshots: :environment do
    current_date = Date.today
    start_date = current_date - 3.days
    end_date = current_date
  
    Profile.where(is_actively_managed: true).each do |profile|
      # Snapshots
      Snapshot::CreateSnapshotWorker.perform_async(profile.id, 'spCampaign')
      Snapshot::CreateSnapshotWorker.perform_async(profile.id, 'spAdGroup')
      Snapshot::CreateSnapshotWorker.perform_async(profile.id, 'spKeyword')
      Snapshot::CreateSnapshotWorker.perform_async(profile.id, 'spTarget')

      # Reports
      if profile.reports.empty?
        # Grab extra data if this is the first time running reports for this profile. Reports can span a maximum of 30 days.
        Report::CreateReportWorker.perform_async(profile.id, (current_date-61.days).to_s, (current_date - 31.day).to_s)
        Report::CreateReportWorker.perform_async(profile.id, (current_date-30.days).to_s, current_date.to_s)
      else
        Report::CreateReportWorker.perform_async(profile.id, start_date.to_s, end_date.to_s)
      end
    end
  end 

end