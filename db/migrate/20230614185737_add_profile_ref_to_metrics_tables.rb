class AddProfileRefToMetricsTables < ActiveRecord::Migration[7.0]
  def up
    add_reference :keyword_metrics, :profile, foreign_key: true, index: false
    add_index :keyword_metrics, [:profile_id, :date]

    KeywordMetric.reset_column_information
    KeywordMetric.find_each do |km|
      km.update!(profile_id: km.keyword.ad_group.campaign.profile.id)
    end

    add_reference :product_targeting_metrics, :profile, foreign_key: true, index: false
    add_index :product_targeting_metrics, [:profile_id, :date]

    ProductTargetingMetric.reset_column_information
    ProductTargetingMetric.find_each do |pm|
      pm.update!(profile_id: pm.product_targeting.ad_group.campaign.profile.id)
    end

  end

  def down
    remove_index :keyword_metrics, [:profile_id, :date]
    remove_reference :keyword_metrics, :profile, foreign_key: true, index: false

    remove_index :product_targeting_metrics, [:profile_id, :date]
    remove_reference :product_targeting_metrics, :profile, foreign_key: true, index: false
  end
  
end
