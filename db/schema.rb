# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_15_064406) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "account_type"
    t.string "external_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "region_id", null: false
    t.index ["external_id"], name: "index_accounts_on_external_id", unique: true
    t.index ["region_id"], name: "index_accounts_on_region_id"
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
    t.index ["ad_group_external_id"], name: "index_ad_groups_on_ad_group_external_id", unique: true
    t.index ["campaign_id"], name: "index_ad_groups_on_campaign_id"
  end

  create_table "api_accounts", force: :cascade do |t|
    t.string "name"
    t.string "encrypted_refresh_token"
    t.string "encrypted_access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "access_token_expires_at"
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
    t.index ["campaign_external_id"], name: "index_campaigns_on_campaign_external_id", unique: true
    t.index ["profile_id"], name: "index_campaigns_on_profile_id"
  end

  create_table "keyword_metrics", force: :cascade do |t|
    t.bigint "keyword_id", null: false
    t.date "date"
    t.integer "impressions"
    t.integer "clicks"
    t.decimal "cost"
    t.decimal "cost_per_click"
    t.decimal "click_through_rate"
    t.integer "purchases_1d"
    t.integer "purchases_7d"
    t.integer "purchases_14d"
    t.integer "purchases_30d"
    t.integer "purchases_same_sku_1d"
    t.integer "purchases_same_sku_7d"
    t.integer "purchases_same_sku_14d"
    t.integer "purchases_same_sku_30d"
    t.integer "units_sold_clicks_1d"
    t.integer "units_sold_clicks_7d"
    t.integer "units_sold_clicks_14d"
    t.integer "units_sold_clicks_30d"
    t.decimal "sales_1d"
    t.decimal "sales_7d"
    t.decimal "sales_14d"
    t.decimal "sales_30d"
    t.decimal "attributed_sales_same_sku_1d"
    t.decimal "attributed_sales_same_sku_7d"
    t.decimal "attributed_sales_same_sku_14d"
    t.decimal "attributed_sales_same_sku_30d"
    t.integer "units_sold_same_sku_1d"
    t.integer "units_sold_same_sku_7d"
    t.integer "units_sold_same_sku_14d"
    t.integer "units_sold_same_sku_30d"
    t.decimal "sales_other_sku_7d"
    t.integer "units_sold_other_sku_7d"
    t.decimal "roas_clicks_7d"
    t.decimal "roas_clicks_14d"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "profile_id"
    t.index ["date", "keyword_id"], name: "index_keyword_metrics_on_date_and_keyword_id", unique: true
    t.index ["keyword_id"], name: "index_keyword_metrics_on_keyword_id"
    t.index ["profile_id", "date"], name: "index_keyword_metrics_on_profile_id_and_date"
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
    t.index ["keyword_external_id"], name: "index_keywords_on_keyword_external_id", unique: true
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
    t.bigint "product_targeting_id", null: false
    t.date "date"
    t.integer "impressions"
    t.integer "clicks"
    t.decimal "cost"
    t.decimal "cost_per_click"
    t.decimal "click_through_rate"
    t.integer "purchases_1d"
    t.integer "purchases_7d"
    t.integer "purchases_14d"
    t.integer "purchases_30d"
    t.integer "purchases_same_sku_1d"
    t.integer "purchases_same_sku_7d"
    t.integer "purchases_same_sku_14d"
    t.integer "purchases_same_sku_30d"
    t.integer "units_sold_clicks_1d"
    t.integer "units_sold_clicks_7d"
    t.integer "units_sold_clicks_14d"
    t.integer "units_sold_clicks_30d"
    t.decimal "sales_1d"
    t.decimal "sales_7d"
    t.decimal "sales_14d"
    t.decimal "sales_30d"
    t.decimal "attributed_sales_same_sku_1d"
    t.decimal "attributed_sales_same_sku_7d"
    t.decimal "attributed_sales_same_sku_14d"
    t.decimal "attributed_sales_same_sku_30d"
    t.integer "units_sold_same_sku_1d"
    t.integer "units_sold_same_sku_7d"
    t.integer "units_sold_same_sku_14d"
    t.integer "units_sold_same_sku_30d"
    t.decimal "sales_other_sku_7d"
    t.integer "units_sold_other_sku_7d"
    t.decimal "roas_clicks_7d"
    t.decimal "roas_clicks_14d"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "profile_id"
    t.index ["date", "product_targeting_id"], name: "index_pt_metrics_on_date_and_pt_id", unique: true
    t.index ["product_targeting_id"], name: "index_product_targeting_metrics_on_product_targeting_id"
    t.index ["profile_id", "date"], name: "index_product_targeting_metrics_on_profile_id_and_date"
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
    t.index ["product_targeting_external_id"], name: "index_product_targetings_on_product_targeting_external_id", unique: true
    t.index ["state"], name: "index_product_targetings_on_state"
  end

  create_table "profile_keyword_metric_summaries", force: :cascade do |t|
    t.bigint "profile_id"
    t.date "date"
    t.integer "impressions"
    t.integer "clicks"
    t.decimal "cost"
    t.decimal "cost_per_click"
    t.decimal "click_through_rate"
    t.integer "purchases_1d"
    t.integer "purchases_7d"
    t.integer "purchases_14d"
    t.integer "purchases_30d"
    t.integer "purchases_same_sku_1d"
    t.integer "purchases_same_sku_7d"
    t.integer "purchases_same_sku_14d"
    t.integer "purchases_same_sku_30d"
    t.integer "units_sold_clicks_1d"
    t.integer "units_sold_clicks_7d"
    t.integer "units_sold_clicks_14d"
    t.integer "units_sold_clicks_30d"
    t.decimal "sales_1d"
    t.decimal "sales_7d"
    t.decimal "sales_14d"
    t.decimal "sales_30d"
    t.decimal "attributed_sales_same_sku_1d"
    t.decimal "attributed_sales_same_sku_7d"
    t.decimal "attributed_sales_same_sku_14d"
    t.decimal "attributed_sales_same_sku_30d"
    t.integer "units_sold_same_sku_1d"
    t.integer "units_sold_same_sku_7d"
    t.integer "units_sold_same_sku_14d"
    t.integer "units_sold_same_sku_30d"
    t.decimal "sales_other_sku_7d"
    t.integer "units_sold_other_sku_7d"
    t.decimal "roas_clicks_7d"
    t.decimal "roas_clicks_14d"
    t.index ["profile_id"], name: "index_profile_keyword_metric_summaries_on_profile_id"
  end

  create_table "profile_metric_summaries", force: :cascade do |t|
    t.bigint "profile_id"
    t.date "date"
    t.integer "impressions"
    t.integer "clicks"
    t.decimal "cost"
    t.decimal "cost_per_click"
    t.decimal "click_through_rate"
    t.integer "purchases_1d"
    t.integer "purchases_7d"
    t.integer "purchases_14d"
    t.integer "purchases_30d"
    t.integer "purchases_same_sku_1d"
    t.integer "purchases_same_sku_7d"
    t.integer "purchases_same_sku_14d"
    t.integer "purchases_same_sku_30d"
    t.integer "units_sold_clicks_1d"
    t.integer "units_sold_clicks_7d"
    t.integer "units_sold_clicks_14d"
    t.integer "units_sold_clicks_30d"
    t.decimal "sales_1d"
    t.decimal "sales_7d"
    t.decimal "sales_14d"
    t.decimal "sales_30d"
    t.decimal "attributed_sales_same_sku_1d"
    t.decimal "attributed_sales_same_sku_7d"
    t.decimal "attributed_sales_same_sku_14d"
    t.decimal "attributed_sales_same_sku_30d"
    t.integer "units_sold_same_sku_1d"
    t.integer "units_sold_same_sku_7d"
    t.integer "units_sold_same_sku_14d"
    t.integer "units_sold_same_sku_30d"
    t.decimal "sales_other_sku_7d"
    t.integer "units_sold_other_sku_7d"
    t.decimal "roas_clicks_7d"
    t.decimal "roas_clicks_14d"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_profile_metric_summaries_on_profile_id"
  end

  create_table "profile_product_targeting_metric_summaries", force: :cascade do |t|
    t.bigint "profile_id"
    t.date "date"
    t.integer "impressions"
    t.integer "clicks"
    t.decimal "cost"
    t.decimal "cost_per_click"
    t.decimal "click_through_rate"
    t.integer "purchases_1d"
    t.integer "purchases_7d"
    t.integer "purchases_14d"
    t.integer "purchases_30d"
    t.integer "purchases_same_sku_1d"
    t.integer "purchases_same_sku_7d"
    t.integer "purchases_same_sku_14d"
    t.integer "purchases_same_sku_30d"
    t.integer "units_sold_clicks_1d"
    t.integer "units_sold_clicks_7d"
    t.integer "units_sold_clicks_14d"
    t.integer "units_sold_clicks_30d"
    t.decimal "sales_1d"
    t.decimal "sales_7d"
    t.decimal "sales_14d"
    t.decimal "sales_30d"
    t.decimal "attributed_sales_same_sku_1d"
    t.decimal "attributed_sales_same_sku_7d"
    t.decimal "attributed_sales_same_sku_14d"
    t.decimal "attributed_sales_same_sku_30d"
    t.integer "units_sold_same_sku_1d"
    t.integer "units_sold_same_sku_7d"
    t.integer "units_sold_same_sku_14d"
    t.integer "units_sold_same_sku_30d"
    t.decimal "sales_other_sku_7d"
    t.integer "units_sold_other_sku_7d"
    t.decimal "roas_clicks_7d"
    t.decimal "roas_clicks_14d"
    t.index ["profile_id"], name: "index_profile_product_targeting_metric_summaries_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "profile_external_id"
    t.datetime "inactive_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "api_account_id", null: false
    t.bigint "marketplace_id"
    t.bigint "account_id"
    t.boolean "is_actively_managed", default: false
    t.index ["account_id"], name: "index_profiles_on_account_id"
    t.index ["api_account_id"], name: "index_profiles_on_api_account_id"
    t.index ["marketplace_id"], name: "index_profiles_on_marketplace_id"
    t.index ["profile_external_id"], name: "index_profiles_on_profile_external_id", unique: true
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
    t.date "start_date"
    t.date "end_date"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_reports_on_profile_id"
    t.index ["report_external_id"], name: "index_reports_on_report_external_id", unique: true
  end

  create_table "snapshots", force: :cascade do |t|
    t.string "snapshot_type"
    t.string "snapshot_external_id"
    t.string "status"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_snapshots_on_profile_id"
    t.index ["snapshot_external_id"], name: "index_snapshots_on_snapshot_external_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "regions"
  add_foreign_key "ad_groups", "campaigns"
  add_foreign_key "campaigns", "profiles"
  add_foreign_key "keyword_metrics", "keywords"
  add_foreign_key "keyword_metrics", "profiles"
  add_foreign_key "keywords", "ad_groups"
  add_foreign_key "marketplaces", "regions"
  add_foreign_key "product_targeting_metrics", "product_targetings"
  add_foreign_key "product_targeting_metrics", "profiles"
  add_foreign_key "product_targetings", "ad_groups"
  add_foreign_key "profile_keyword_metric_summaries", "profiles"
  add_foreign_key "profile_metric_summaries", "profiles"
  add_foreign_key "profile_product_targeting_metric_summaries", "profiles"
  add_foreign_key "profiles", "accounts"
  add_foreign_key "profiles", "api_accounts"
  add_foreign_key "profiles", "marketplaces"
  add_foreign_key "reports", "profiles"
  add_foreign_key "snapshots", "profiles"
end
