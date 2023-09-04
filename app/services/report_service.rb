class ReportService

  def create_report(profile, start_date, end_date)
    path = "/reporting/reports"
    ad_service = AmazonAdvertisingService.new(profile.api_account, profile.marketplace.region, profile)

    body = {
      "startDate": start_date,
      "endDate": end_date,
      "configuration": {
        "adProduct": "SPONSORED_PRODUCTS",
        "groupBy": ["targeting"],
        "columns": ["date", "adGroupId","campaignId", "targeting", "keywordId", "matchType", "impressions", "clicks", "costPerClick", "clickThroughRate", "cost", "purchases1d", "purchases7d", "purchases14d", "purchases30d", "purchasesSameSku1d", "purchasesSameSku7d", "purchasesSameSku14d", "purchasesSameSku30d", "unitsSoldClicks1d", "unitsSoldClicks7d", "unitsSoldClicks14d", "unitsSoldClicks30d", "sales1d", "sales7d", "sales14d", "sales30d", "attributedSalesSameSku1d", "attributedSalesSameSku7d", "attributedSalesSameSku14d", "attributedSalesSameSku30d", "unitsSoldSameSku1d", "unitsSoldSameSku7d", "unitsSoldSameSku14d", "unitsSoldSameSku30d", "salesOtherSku7d", "unitsSoldOtherSku7d", "acosClicks7d", "acosClicks14d", "roasClicks7d", "roasClicks14d"],
        "reportTypeId": "spTargeting",
        "timeUnit": "DAILY",
        "format": "GZIP_JSON"
      }
    }

    report_data = ad_service.post(path, body)

    # Create a Report record in the database
    Report.create!(
      report_external_id: report_data['reportId'],
      start_date: report_data['startDate'].to_date,
      end_date: report_data['endDate'].to_date,
      status: report_data['status'],
      profile: profile,
      report_type: report_data['configuration']['reportTypeId'],
    )
  end

  def update_report_status(report)
    path = "/reporting/reports/#{report.report_external_id}"
    ad_service = AmazonAdvertisingService.new(report.profile.api_account, report.profile.marketplace.region, report.profile)

    report_status = ad_service.get(path)

    # Update the report status in the database
    report.update!(
      status: report_status['status'],
      url: report_status['url']
    )

    report_status['status']
  end

  def download_and_process_report(report)
    conn = Faraday.new
  
    begin
      response = conn.get report.url
      raise "Report download failed with status: #{response.status}" unless response.success?
  
      file = File.join(Rails.root, 'tmp', "report-#{report.report_external_id}.json.gz")
      File.open(file, 'wb') do |fp|
        fp.write(response.body)
      end
  
      # Process the data and load into the database
      process_report_data(file, report.profile)
  
      File.delete(file) if File.exist?(file)
    rescue StandardError => e
      Rails.logger.error "Error in download_and_process_report: #{e.message}"
      report.update!(status: 'FAILED')
      raise e
    end
  end
 
  def process_report_data(file, profile)
    Zlib::GzipReader.open(file) do |gz|
      data = JSON.parse(gz.read)
  
      data.each do |record|
        case record["matchType"]
        when "TARGETING_EXPRESSION", "TARGETING_EXPRESSION_PREDEFINED"
          ProductTargetingMetric.create_from_report(record, profile)
        when "BROAD", "PHRASE", "EXACT"
          KeywordMetric.create_from_report(record, profile)
        else
          Rails.logger.warn "Unknown matchType: #{record["matchType"]}"
        end
      end
    end
  
  end
end
