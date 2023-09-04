# == Schema Information
#
# Table name: profile_product_targeting_metric_summaries
#
#  id                            :bigint           not null, primary key
#  profile_id                    :bigint
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
#
class ProfileProductTargetingMetricSummary < ApplicationRecord
  belongs_to :profile
  
end
