class AddUniqueIndexToProductTargetingMetrics < ActiveRecord::Migration[7.0]
  def change
    add_index :product_targeting_metrics, [:date, :product_targeting_id], unique: true, name: 'index_pt_metrics_on_date_and_pt_id'
  end
end
