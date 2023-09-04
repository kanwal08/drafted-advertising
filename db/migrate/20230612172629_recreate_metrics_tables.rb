class RecreateMetricsTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :keyword_metrics
    drop_table :product_targeting_metrics

    create_table :keyword_metrics do |t|
      t.references :keyword, null: false, foreign_key: true
      t.date :date
      t.integer :impressions
      t.integer :clicks
      t.decimal :cost
      t.decimal :cost_per_click
      t.decimal :click_through_rate
      t.integer :purchases_1d
      t.integer :purchases_7d
      t.integer :purchases_14d
      t.integer :purchases_30d
      t.integer :purchases_same_sku_1d
      t.integer :purchases_same_sku_7d
      t.integer :purchases_same_sku_14d
      t.integer :purchases_same_sku_30d
      t.integer :units_sold_clicks_1d
      t.integer :units_sold_clicks_7d
      t.integer :units_sold_clicks_14d
      t.integer :units_sold_clicks_30d
      t.decimal :sales_1d
      t.decimal :sales_7d
      t.decimal :sales_14d
      t.decimal :sales_30d
      t.decimal :attributed_sales_same_sku_1d
      t.decimal :attributed_sales_same_sku_7d
      t.decimal :attributed_sales_same_sku_14d
      t.decimal :attributed_sales_same_sku_30d
      t.integer :units_sold_same_sku_1d
      t.integer :units_sold_same_sku_7d
      t.integer :units_sold_same_sku_14d
      t.integer :units_sold_same_sku_30d
      t.decimal :sales_other_sku_7d
      t.integer :units_sold_other_sku_7d
      t.decimal :roas_clicks_7d
      t.decimal :roas_clicks_14d
      t.timestamps
    end

    create_table :product_targeting_metrics do |t|
      t.references :product_targeting, null: false, foreign_key: true
      t.date :date
      t.integer :impressions
      t.integer :clicks
      t.decimal :cost
      t.decimal :cost_per_click
      t.decimal :click_through_rate
      t.integer :purchases_1d
      t.integer :purchases_7d
      t.integer :purchases_14d
      t.integer :purchases_30d
      t.integer :purchases_same_sku_1d
      t.integer :purchases_same_sku_7d
      t.integer :purchases_same_sku_14d
      t.integer :purchases_same_sku_30d
      t.integer :units_sold_clicks_1d
      t.integer :units_sold_clicks_7d
      t.integer :units_sold_clicks_14d
      t.integer :units_sold_clicks_30d
      t.decimal :sales_1d
      t.decimal :sales_7d
      t.decimal :sales_14d
      t.decimal :sales_30d
      t.decimal :attributed_sales_same_sku_1d
      t.decimal :attributed_sales_same_sku_7d
      t.decimal :attributed_sales_same_sku_14d
      t.decimal :attributed_sales_same_sku_30d
      t.integer :units_sold_same_sku_1d
      t.integer :units_sold_same_sku_7d
      t.integer :units_sold_same_sku_14d
      t.integer :units_sold_same_sku_30d
      t.decimal :sales_other_sku_7d
      t.integer :units_sold_other_sku_7d
      t.decimal :roas_clicks_7d
      t.decimal :roas_clicks_14d
      t.timestamps
    end

  end
end
