class AddUniqueConstraintToExternalIds < ActiveRecord::Migration[7.0]
  def change
    remove_index :accounts, :external_id if index_exists?(:accounts, :external_id)
    add_index :accounts, :external_id, unique: true

    remove_index :ad_groups, :ad_group_external_id if index_exists?(:ad_groups, :ad_group_external_id)
    add_index :ad_groups, :ad_group_external_id, unique: true

    remove_index :campaigns, :campaign_external_id if index_exists?(:campaigns, :campaign_external_id)
    add_index :campaigns, :campaign_external_id, unique: true

    remove_index :keywords, :keyword_external_id if index_exists?(:keywords, :keyword_external_id)
    add_index :keywords, :keyword_external_id, unique: true

    remove_index :product_targetings, :product_targeting_external_id if index_exists?(:product_targetings, :product_targeting_external_id)
    add_index :product_targetings, :product_targeting_external_id, unique: true

    remove_index :profiles, :profile_external_id if index_exists?(:profiles, :profile_external_id)
    add_index :profiles, :profile_external_id, unique: true

    remove_index :reports, :report_external_id if index_exists?(:reports, :report_external_id)
    add_index :reports, :report_external_id, unique: true

    remove_index :snapshots, :snapshot_external_id if index_exists?(:snapshots, :snapshot_external_id)
    add_index :snapshots, :snapshot_external_id, unique: true
  end
end
