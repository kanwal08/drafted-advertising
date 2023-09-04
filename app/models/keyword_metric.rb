# == Schema Information
#
# Table name: keyword_metrics
#
#  id                            :bigint           not null, primary key
#  keyword_id                    :bigint           not null
#  date                          :date
#  impressions                   :integer
#  clicks                        :integer
#  cost                          :decimal(, )
#  cost_per_click                :decimal(, )
#  click_through_rate            :decimal(, )
#  purchases_1d                  :integer
#  purchases_7d                  :integer
#  purchases_14d                 :integer
#  purchases_30d                 :integer
#  purchases_same_sku_1d         :integer
#  purchases_same_sku_7d         :integer
#  purchases_same_sku_14d        :integer
#  purchases_same_sku_30d        :integer
#  units_sold_clicks_1d          :integer
#  units_sold_clicks_7d          :integer
#  units_sold_clicks_14d         :integer
#  units_sold_clicks_30d         :integer
#  sales_1d                      :decimal(, )
#  sales_7d                      :decimal(, )
#  sales_14d                     :decimal(, )
#  sales_30d                     :decimal(, )
#  attributed_sales_same_sku_1d  :decimal(, )
#  attributed_sales_same_sku_7d  :decimal(, )
#  attributed_sales_same_sku_14d :decimal(, )
#  attributed_sales_same_sku_30d :decimal(, )
#  units_sold_same_sku_1d        :integer
#  units_sold_same_sku_7d        :integer
#  units_sold_same_sku_14d       :integer
#  units_sold_same_sku_30d       :integer
#  sales_other_sku_7d            :decimal(, )
#  units_sold_other_sku_7d       :integer
#  roas_clicks_7d                :decimal(, )
#  roas_clicks_14d               :decimal(, )
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  profile_id                    :bigint
#
class KeywordMetric < ApplicationRecord
  belongs_to :keyword
  belongs_to :profile

  def self.create_from_report(record, profile)
    keyword = Keyword.find_by(keyword_external_id: record['keywordId'])

    unless keyword
      campaign = Campaign.find_or_create_by(campaign_external_id: record['campaignId'].to_s, profile: profile)
      ad_group = AdGroup.find_or_create_by(ad_group_external_id: record['adGroupId'], campaign: campaign)
      keyword = Keyword.create!(keyword_external_id: record['keywordId'], ad_group: ad_group)
    end
    
    metric = find_or_create_by(date: record["date"], keyword: keyword)

    metric.update!(
      profile: profile,
      impressions: record["impressions"],
      clicks: record["clicks"],
      cost: record["cost"],
      cost_per_click: record["costPerClick"],
      click_through_rate: record["clickThroughRate"],
      purchases_1d: record["purchases1d"],
      purchases_7d: record["purchases7d"],
      purchases_14d: record["purchases14d"],
      purchases_30d: record["purchases30d"],
      purchases_same_sku_1d: record["purchasesSameSku1d"],
      purchases_same_sku_7d: record["purchasesSameSku7d"],
      purchases_same_sku_14d: record["purchasesSameSku14d"],
      purchases_same_sku_30d: record["purchasesSameSku30d"],
      units_sold_clicks_1d: record["unitsSoldClicks1d"],
      units_sold_clicks_7d: record["unitsSoldClicks7d"],
      units_sold_clicks_14d: record["unitsSoldClicks14d"],
      units_sold_clicks_30d: record["unitsSoldClicks30d"],
      sales_1d: record["sales1d"],
      sales_7d: record["sales7d"],
      sales_14d: record["sales14d"],
      sales_30d: record["sales30d"],
      attributed_sales_same_sku_1d: record["attributedSalesSameSku1d"],
      attributed_sales_same_sku_7d: record["attributedSalesSameSku7d"],
      attributed_sales_same_sku_14d: record["attributedSalesSameSku14d"],
      attributed_sales_same_sku_30d: record["attributedSalesSameSku30d"],
      units_sold_same_sku_1d: record["unitsSoldSameSku1d"],
      units_sold_same_sku_7d: record["unitsSoldSameSku7d"],
      units_sold_same_sku_14d: record["unitsSoldSameSku14d"],
      units_sold_same_sku_30d: record["unitsSoldSameSku30d"],
      sales_other_sku_7d: record["salesOtherSku7d"],
      units_sold_other_sku_7d: record["unitsSoldOtherSku7d"],
      roas_clicks_7d: record["roasClicks7d"],
      roas_clicks_14d: record["roasClicks14d"]
    )
  end
  
    
end
