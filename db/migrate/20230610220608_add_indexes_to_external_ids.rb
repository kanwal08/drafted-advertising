class AddIndexesToExternalIds < ActiveRecord::Migration[7.0]
  def change
    add_index :accounts, :external_id
    add_index :ad_groups, :ad_group_external_id
    add_index :campaigns, :campaign_external_id
    add_index :keywords, :keyword_external_id
    add_index :product_targetings, :product_targeting_external_id
    add_index :profiles, :profile_external_id
    add_index :reports, :report_external_id
    add_index :snapshots, :snapshot_external_id
  end
end