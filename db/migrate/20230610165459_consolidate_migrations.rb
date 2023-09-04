class ConsolidateMigrations < ActiveRecord::Migration[7.0]
  def change
    create_table "accounts", force: :cascade do |t|
      t.string "name"
      t.string "account_type"
      t.string "external_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "ad_groups", force: :cascade do |t|
      t.datetime "last_retrieved_at"
      t.string "name"
      t.string "ad_group_external_id"
      t.decimal "default_bid"
      t.string "state"
      t.bigint "campaign_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["campaign_id"], name: "index_ad_groups_on_campaign_id"
    end
  
    create_table "api_accounts", force: :cascade do |t|
      t.string "name"
      t.string "encrypted_refresh_token"
      t.string "encrypted_access_token"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "campaigns", force: :cascade do |t|
      t.datetime "last_retrieved_at"
      t.string "name"
      t.string "campaign_external_id"
      t.string "campaign_type"
      t.string "targeting_type"
      t.boolean "premium_bid_adjustment"
      t.decimal "daily_budget"
      t.date "start_date"
      t.string "state"
      t.string "bidding_strategy"
      t.bigint "profile_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["profile_id"], name: "index_campaigns_on_profile_id"
    end
  
    create_table "keyword_metrics", force: :cascade do |t|
      t.datetime "date"
      t.string "impressions"
      t.integer "clicks"
      t.string "cost"
      t.string "attributed_sales_1d"
      t.string "attributed_sales_7d"
      t.string "attributed_sales_14d"
      t.string "attributed_sales_30d"
      t.string "attributed_sales_1d_same_sku"
      t.string "attributed_sales_7d_same_sku"
      t.string "attributed_sales_14d_same_sku"
      t.string "attributed_sales_30d_same_sku"
      t.string "attributed_conversions_1d"
      t.string "attributed_conversions_7d"
      t.string "attributed_conversions_14d"
      t.string "attributed_conversions_30d"
      t.string "attributed_conversions_1d_same_sku"
      t.string "attributed_conversions_7d_same_sku"
      t.string "attributed_conversions_14d_same_sku"
      t.string "attributed_conversions_30d_same_sku"
      t.string "attributed_units_ordered_1d"
      t.string "attributed_units_ordered_7d"
      t.string "attributed_units_ordered_14d"
      t.string "attributed_units_ordered_30d"
      t.bigint "keyword_id"
      t.index ["keyword_id"], name: "index_keyword_metrics_on_keyword_id"
    end
  
    create_table "keywords", force: :cascade do |t|
      t.datetime "last_retrieved_at"
      t.string "keyword_text"
      t.string "match_type"
      t.string "keyword_external_id"
      t.string "state"
      t.decimal "bid"
      t.bigint "ad_group_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["ad_group_id"], name: "index_keywords_on_ad_group_id"
    end
  
    create_table "marketplaces", force: :cascade do |t|
      t.string "name"
      t.string "external_id"
      t.string "country_code"
      t.string "currency_code"
      t.string "timezone"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "region_id"
      t.index ["region_id"], name: "index_marketplaces_on_region_id"
    end
  
    create_table "product_targeting_metrics", force: :cascade do |t|
      t.datetime "date"
      t.string "impressions"
      t.integer "clicks"
      t.string "cost"
      t.string "attributed_sales_1d"
      t.string "attributed_sales_7d"
      t.string "attributed_sales_14d"
      t.string "attributed_sales_30d"
      t.string "attributed_sales_1d_same_sku"
      t.string "attributed_sales_7d_same_sku"
      t.string "attributed_sales_14d_same_sku"
      t.string "attributed_sales_30d_same_sku"
      t.string "attributed_conversions_1d"
      t.string "attributed_conversions_7d"
      t.string "attributed_conversions_14d"
      t.string "attributed_conversions_30d"
      t.string "attributed_conversions_1d_same_sku"
      t.string "attributed_conversions_7d_same_sku"
      t.string "attributed_conversions_14d_same_sku"
      t.string "attributed_conversions_30d_same_sku"
      t.string "attributed_units_ordered_1d"
      t.string "attributed_units_ordered_7d"
      t.string "attributed_units_ordered_14d"
      t.string "attributed_units_ordered_30d"
      t.bigint "product_targeting_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["product_targeting_id"], name: "index_product_targeting_metrics_on_product_targeting_id"
    end
  
    create_table "product_targetings", force: :cascade do |t|
      t.datetime "last_retrieved_at"
      t.integer "expression_type"
      t.string "product_targeting_external_id"
      t.string "state"
      t.decimal "bid"
      t.bigint "ad_group_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["ad_group_id"], name: "index_product_targetings_on_ad_group_id"
      t.index ["expression_type"], name: "index_product_targetings_on_expression_type"
      t.index ["last_retrieved_at"], name: "index_product_targetings_on_last_retrieved_at"
      t.index ["state"], name: "index_product_targetings_on_state"
    end
  
    create_table "profiles", force: :cascade do |t|
      t.string "profile_external_id"
      t.datetime "inactive_at"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "api_account_id", null: false
      t.bigint "marketplace_id"
      t.bigint "account_id"
      t.index ["account_id"], name: "index_profiles_on_account_id"
      t.index ["api_account_id"], name: "index_profiles_on_api_account_id"
      t.index ["marketplace_id"], name: "index_profiles_on_marketplace_id"
    end
  
    create_table "regions", force: :cascade do |t|
      t.string "name"
      t.string "code"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "reports", force: :cascade do |t|
      t.string "report_type"
      t.string "report_external_id"
      t.string "status"
      t.string "url"
      t.string "start_date"
      t.string "end_date"
      t.boolean "loaded_in_db"
      t.bigint "profile_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["profile_id"], name: "index_reports_on_profile_id"
    end
  
    create_table "snapshots", force: :cascade do |t|
      t.string "snapshot_type"
      t.string "snapshot_external_id"
      t.string "status"
      t.string "location"
      t.boolean "loaded_in_db"
      t.bigint "profile_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["profile_id"], name: "index_snapshots_on_profile_id"
    end
  
    add_foreign_key "ad_groups", "campaigns"
    add_foreign_key "campaigns", "profiles"
    add_foreign_key "keyword_metrics", "keywords"
    add_foreign_key "keywords", "ad_groups"
    add_foreign_key "marketplaces", "regions"
    add_foreign_key "product_targeting_metrics", "product_targetings"
    add_foreign_key "product_targetings", "ad_groups"
    add_foreign_key "profiles", "accounts"
    add_foreign_key "profiles", "api_accounts"
    add_foreign_key "profiles", "marketplaces"
    add_foreign_key "reports", "profiles"
    add_foreign_key "snapshots", "profiles"
  
  end
end
