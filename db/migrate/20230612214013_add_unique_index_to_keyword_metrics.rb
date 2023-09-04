class AddUniqueIndexToKeywordMetrics < ActiveRecord::Migration[7.0]
  def change
    add_index :keyword_metrics, [:keyword_id, :date], unique: true
  end
end
