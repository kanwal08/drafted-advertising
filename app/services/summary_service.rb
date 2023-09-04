class SummaryService

  # refresh all metric summaries for all active profiles
  def refresh_all_metric_summaries
    Profile.all.each do |profile|
      next if profile.reports.empty?
      
      start_date = profile.reports.where(status: 'PROCESSED').minimum(:start_date)
      end_date = profile.reports.where(status: 'PROCESSED').maximum(:end_date)

      (start_date..end_date).each do |date|
        update_profile_metric_summaries(profile, date)
      end
    end
  end

  def update_profile_metric_summaries(profile, date)
    update_metric_summaries(profile, date, KeywordMetric, ProfileKeywordMetricSummary)
    update_metric_summaries(profile, date, ProductTargetingMetric, ProfileProductTargetingMetricSummary)

    update_aggregated_profile_metric_summary(profile, date)
  end

  private

  def update_metric_summaries(profile, date, klass, summary_klass)
    aggregated_metrics = klass.where(profile: profile, date: date)
                                      .group(:profile_id, :date)
                                      .select('profile_id, date, SUM(impressions) as total_impressions,
                                               SUM(clicks) as total_clicks, SUM(cost) as total_cost,
                                               SUM(purchases_1d) as total_purchases_1d,
                                               SUM(purchases_7d) as total_purchases_7d,
                                               SUM(purchases_14d) as total_purchases_14d,
                                               SUM(purchases_30d) as total_purchases_30d,
                                               SUM(purchases_same_sku_1d) as total_purchases_same_sku_1d,
                                               SUM(purchases_same_sku_7d) as total_purchases_same_sku_7d,
                                               SUM(purchases_same_sku_14d) as total_purchases_same_sku_14d,
                                               SUM(purchases_same_sku_30d) as total_purchases_same_sku_30d,
                                               SUM(units_sold_clicks_1d) as total_units_sold_clicks_1d,
                                               SUM(units_sold_clicks_7d) as total_units_sold_clicks_7d,
                                               SUM(units_sold_clicks_14d) as total_units_sold_clicks_14d,
                                               SUM(units_sold_clicks_30d) as total_units_sold_clicks_30d,
                                               SUM(sales_1d) as total_sales_1d,
                                               SUM(sales_7d) as total_sales_7d,
                                               SUM(sales_14d) as total_sales_14d,
                                               SUM(sales_30d) as total_sales_30d,
                                               SUM(attributed_sales_same_sku_1d) as total_attributed_sales_same_sku_1d,
                                               SUM(attributed_sales_same_sku_7d) as total_attributed_sales_same_sku_7d,
                                               SUM(attributed_sales_same_sku_14d) as total_attributed_sales_same_sku_14d,
                                               SUM(attributed_sales_same_sku_30d) as total_attributed_sales_same_sku_30d,
                                               SUM(units_sold_same_sku_1d) as total_units_sold_same_sku_1d,
                                               SUM(units_sold_same_sku_7d) as total_units_sold_same_sku_7d,
                                               SUM(units_sold_same_sku_14d) as total_units_sold_same_sku_14d,
                                               SUM(units_sold_same_sku_30d) as total_units_sold_same_sku_30d,
                                               SUM(sales_other_sku_7d) as total_sales_other_sku_7d,
                                               SUM(units_sold_other_sku_7d) as total_units_sold_other_sku_7d')

    aggregated_metrics.each do |metric|
      summary = summary_klass.find_or_initialize_by(profile: profile, date: date)
      summary.update!(
        impressions: metric.total_impressions,
        clicks: metric.total_clicks,
        cost: metric.total_cost.round(2),
        cost_per_click: (metric.total_cost / metric.total_clicks.to_f).round(2),
        click_through_rate: (metric.total_clicks.to_f / metric.total_impressions.to_f).round(10),
        purchases_1d: metric.total_purchases_1d,
        purchases_7d: metric.total_purchases_7d,
        purchases_14d: metric.total_purchases_14d,
        purchases_30d: metric.total_purchases_30d,
        purchases_same_sku_1d: metric.total_purchases_same_sku_1d,
        purchases_same_sku_7d: metric.total_purchases_same_sku_7d,
        purchases_same_sku_14d: metric.total_purchases_same_sku_14d,
        purchases_same_sku_30d: metric.total_purchases_same_sku_30d,
        units_sold_clicks_1d: metric.total_units_sold_clicks_1d,
        units_sold_clicks_7d: metric.total_units_sold_clicks_7d,
        units_sold_clicks_14d: metric.total_units_sold_clicks_14d,
        units_sold_clicks_30d: metric.total_units_sold_clicks_30d,
        sales_1d: metric.total_sales_1d.round(2),
        sales_7d: metric.total_sales_7d.round(2),
        sales_14d: metric.total_sales_14d.round(2),
        sales_30d: metric.total_sales_30d.round(2),
        attributed_sales_same_sku_1d: metric.total_attributed_sales_same_sku_1d.round(2),
        attributed_sales_same_sku_7d: metric.total_attributed_sales_same_sku_7d.round(2),
        attributed_sales_same_sku_14d: metric.total_attributed_sales_same_sku_14d.round(2),
        attributed_sales_same_sku_30d: metric.total_attributed_sales_same_sku_30d.round(2),
        units_sold_same_sku_1d: metric.total_units_sold_same_sku_1d,
        units_sold_same_sku_7d: metric.total_units_sold_same_sku_7d,
        units_sold_same_sku_14d: metric.total_units_sold_same_sku_14d,
        units_sold_same_sku_30d: metric.total_units_sold_same_sku_30d,
        sales_other_sku_7d: metric.total_sales_other_sku_7d.round(2),
        units_sold_other_sku_7d: metric.total_units_sold_other_sku_7d,
        roas_clicks_7d: (metric.total_sales_7d / metric.total_cost.to_f).round(10),
        roas_clicks_14d: (metric.total_sales_14d / metric.total_cost.to_f).round(10)
      )
    end
  end

  def update_aggregated_profile_metric_summary(profile, date)
    # Get the keyword and product targeting metrics
    keyword_metrics = ProfileKeywordMetricSummary.where(profile: profile, date: date).first
    product_targeting_metrics = ProfileProductTargetingMetricSummary.where(profile: profile, date: date).first

    return if keyword_metrics.nil? && product_targeting_metrics.nil?
  
    # Create or update the aggregated metric
    aggregated_metric = ProfileMetricSummary.find_or_initialize_by(profile: profile, date: date)
    
    # Aggregate the metrics. This example just adds them together
    aggregated_metric.update!(
      impressions: (keyword_metrics&.impressions || 0) + (product_targeting_metrics&.impressions || 0),
      clicks: (keyword_metrics&.clicks || 0) + (product_targeting_metrics&.clicks || 0),
      cost: ((keyword_metrics&.cost || 0) + (product_targeting_metrics&.cost || 0)).round(2),
      cost_per_click: (((keyword_metrics&.cost || 0) + (product_targeting_metrics&.cost || 0)) / (((keyword_metrics&.clicks || 0) + (product_targeting_metrics&.clicks || 0)).to_f)).round(2),
      click_through_rate: ((((keyword_metrics&.clicks || 0) + (product_targeting_metrics&.clicks || 0)).to_f) / (((keyword_metrics&.impressions || 0) + (product_targeting_metrics&.impressions || 0)).to_f)).round(10),
      purchases_1d: (keyword_metrics&.purchases_1d || 0) + (product_targeting_metrics&.purchases_1d || 0),
      purchases_7d: (keyword_metrics&.purchases_7d || 0) + (product_targeting_metrics&.purchases_7d || 0),
      purchases_14d: (keyword_metrics&.purchases_14d || 0) + (product_targeting_metrics&.purchases_14d || 0),
      purchases_30d: (keyword_metrics&.purchases_30d || 0) + (product_targeting_metrics&.purchases_30d || 0),
      purchases_same_sku_1d: (keyword_metrics&.purchases_same_sku_1d || 0) + (product_targeting_metrics&.purchases_same_sku_1d || 0),
      purchases_same_sku_7d: (keyword_metrics&.purchases_same_sku_7d || 0) + (product_targeting_metrics&.purchases_same_sku_7d || 0),
      purchases_same_sku_14d: (keyword_metrics&.purchases_same_sku_14d || 0) + (product_targeting_metrics&.purchases_same_sku_14d || 0),
      purchases_same_sku_30d: (keyword_metrics&.purchases_same_sku_30d || 0) + (product_targeting_metrics&.purchases_same_sku_30d || 0),
      units_sold_clicks_1d: (keyword_metrics&.units_sold_clicks_1d || 0) + (product_targeting_metrics&.units_sold_clicks_1d || 0),
      units_sold_clicks_7d: (keyword_metrics&.units_sold_clicks_7d || 0) + (product_targeting_metrics&.units_sold_clicks_7d || 0),
      units_sold_clicks_14d: (keyword_metrics&.units_sold_clicks_14d || 0) + (product_targeting_metrics&.units_sold_clicks_14d || 0),
      units_sold_clicks_30d: (keyword_metrics&.units_sold_clicks_30d || 0) + (product_targeting_metrics&.units_sold_clicks_30d || 0),
      units_sold_same_sku_1d: (keyword_metrics&.units_sold_same_sku_1d || 0) + (product_targeting_metrics&.units_sold_same_sku_1d || 0),
      units_sold_same_sku_7d: (keyword_metrics&.units_sold_same_sku_7d || 0) + (product_targeting_metrics&.units_sold_same_sku_7d || 0),
      units_sold_same_sku_14d: (keyword_metrics&.units_sold_same_sku_14d || 0) + (product_targeting_metrics&.units_sold_same_sku_14d || 0),
      units_sold_same_sku_30d: (keyword_metrics&.units_sold_same_sku_30d || 0) + (product_targeting_metrics&.units_sold_same_sku_30d || 0),
      units_sold_other_sku_7d: (keyword_metrics&.units_sold_other_sku_7d || 0) + (product_targeting_metrics&.units_sold_other_sku_7d || 0),
      sales_1d: (keyword_metrics&.sales_1d || 0) + (product_targeting_metrics&.sales_1d || 0).round(2),
      sales_7d: (keyword_metrics&.sales_7d || 0) + (product_targeting_metrics&.sales_7d || 0).round(2),
      sales_14d: (keyword_metrics&.sales_14d || 0) + (product_targeting_metrics&.sales_14d || 0).round(2),
      sales_30d: (keyword_metrics&.sales_30d || 0) + (product_targeting_metrics&.sales_30d || 0).round(2),
      sales_other_sku_7d: (keyword_metrics&.sales_other_sku_7d || 0) + (product_targeting_metrics&.sales_other_sku_7d || 0).round(2),
      attributed_sales_same_sku_1d: (keyword_metrics&.attributed_sales_same_sku_1d || 0) + (product_targeting_metrics&.attributed_sales_same_sku_1d || 0).round(2),
      attributed_sales_same_sku_7d: (keyword_metrics&.attributed_sales_same_sku_7d || 0) + (product_targeting_metrics&.attributed_sales_same_sku_7d || 0).round(2),
      attributed_sales_same_sku_14d: (keyword_metrics&.attributed_sales_same_sku_14d || 0) + (product_targeting_metrics&.attributed_sales_same_sku_14d || 0).round(2),
      attributed_sales_same_sku_30d: (keyword_metrics&.attributed_sales_same_sku_30d || 0) + (product_targeting_metrics&.attributed_sales_same_sku_30d || 0).round(2),
      roas_clicks_7d: (((keyword_metrics&.sales_7d || 0) + (product_targeting_metrics&.sales_7d || 0)) / (((keyword_metrics&.cost || 0) + (product_targeting_metrics&.cost || 0)).to_f)).round(10),
      roas_clicks_14d: (((keyword_metrics&.sales_14d || 0) + (product_targeting_metrics&.sales_14d || 0)) / (((keyword_metrics&.cost || 0) + (product_targeting_metrics&.cost || 0)).to_f)).round(10)
    )
  end

end