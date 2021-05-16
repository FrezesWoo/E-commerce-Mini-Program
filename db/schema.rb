# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_15_082304) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string "file_file_name"
    t.string "file_content_type"
    t.bigint "file_file_size"
    t.datetime "file_updated_at"
    t.integer "weight"
    t.string "alt"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "attachable_id"
    t.string "attachable_type"
    t.boolean "display", default: true
    t.integer "ordering"
  end

  create_table "campaign_blocks", force: :cascade do |t|
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.string "video_file_name"
    t.string "video_content_type"
    t.bigint "video_file_size"
    t.datetime "video_updated_at"
    t.bigint "mp_link_id"
    t.float "x_position"
    t.float "y_position"
    t.float "link_width"
    t.float "link_height"
    t.integer "template"
    t.integer "ordering"
    t.bigint "product_id"
    t.bigint "product_package_id"
    t.bigint "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
    t.index ["campaign_id"], name: "index_campaign_blocks_on_campaign_id"
    t.index ["mp_link_id"], name: "index_campaign_blocks_on_mp_link_id"
    t.index ["product_id"], name: "index_campaign_blocks_on_product_id"
    t.index ["product_package_id"], name: "index_campaign_blocks_on_product_package_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "page_type"
    t.boolean "publish"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "data_fingerprint"
    t.string "type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "country_province_translations", force: :cascade do |t|
    t.bigint "country_province_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["country_province_id"], name: "index_country_province_translations_on_country_province_id"
    t.index ["locale"], name: "index_country_province_translations_on_locale"
  end

  create_table "country_provinces", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_country_provinces_on_country_id"
  end

  create_table "country_provinces_delivery_fees", id: :serial, force: :cascade do |t|
    t.bigint "delivery_fee_id", null: false
    t.bigint "country_province_id", null: false
  end

  create_table "country_translations", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["country_id"], name: "index_country_translations_on_country_id"
    t.index ["locale"], name: "index_country_translations_on_locale"
  end

  create_table "coupon_product_skus", force: :cascade do |t|
    t.bigint "coupon_id"
    t.bigint "product_sku_id"
    t.integer "quantity"
    t.index ["coupon_id"], name: "index_coupon_product_skus_on_coupon_id"
    t.index ["product_sku_id"], name: "index_coupon_product_skus_on_product_sku_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.string "code"
    t.integer "condition"
    t.float "price_condition"
    t.bigint "product_condition"
    t.boolean "is_disposable", default: false
    t.integer "status", default: 1
    t.datetime "expiry_start_date"
    t.datetime "expiry_end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customer_tokens", force: :cascade do |t|
    t.datetime "expire_at"
    t.string "token"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_customer_tokens_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.integer "gender"
    t.string "name"
    t.string "open_id", null: false
    t.string "union_id"
    t.jsonb "wechat_data"
    t.string "email"
    t.string "phone"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "wechat_session_key"
    t.datetime "birthday"
    t.string "crm_member_no"
    t.boolean "agreed_marketing"
    t.index ["open_id"], name: "index_customers_on_open_id", unique: true
    t.index ["phone"], name: "unique_phone", unique: true
    t.index ["union_id"], name: "unique_union_id", unique: true
  end

  create_table "delivery_fees", force: :cascade do |t|
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "douyin_customer_tokens", force: :cascade do |t|
    t.string "token"
    t.datetime "expire_at"
    t.bigint "douyin_customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["douyin_customer_id"], name: "index_douyin_customer_tokens_on_douyin_customer_id"
  end

  create_table "douyin_customers", force: :cascade do |t|
    t.string "open_id", null: false
    t.string "union_id"
    t.string "name"
    t.integer "gender"
    t.string "phone"
    t.string "email"
    t.datetime "birthday"
    t.jsonb "douyin_data"
    t.string "douyin_session_key"
    t.string "crm_member_no"
    t.boolean "agreed_marketing"
    t.string "reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["open_id"], name: "index_douyin_customers_on_open_id", unique: true
    t.index ["phone"], name: "index_douyin_customers_on_phone", unique: true
    t.index ["union_id"], name: "index_douyin_customers_on_union_id", unique: true
  end

  create_table "gift_cards", force: :cascade do |t|
    t.integer "updated_by_id"
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lucky_draw_prize_codes", force: :cascade do |t|
    t.bigint "lucky_draw_prize_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "coupon_id"
    t.boolean "status", default: true
    t.index ["coupon_id"], name: "index_lucky_draw_prize_codes_on_coupon_id"
    t.index ["lucky_draw_prize_id"], name: "index_lucky_draw_prize_codes_on_lucky_draw_prize_id"
  end

  create_table "lucky_draw_prizes", force: :cascade do |t|
    t.string "name"
    t.integer "quantity"
    t.boolean "sample_prize", default: false
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_package_id"
    t.integer "prize_type"
    t.index ["product_package_id"], name: "index_lucky_draw_prizes_on_product_package_id"
  end

  create_table "lucky_draws", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "lucky_draw_prize_id"
    t.bigint "lucky_draw_prize_code_id"
    t.string "name"
    t.string "mobile"
    t.string "province"
    t.string "city"
    t.string "area"
    t.string "address"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_lucky_draws_on_customer_id"
    t.index ["lucky_draw_prize_code_id"], name: "index_lucky_draws_on_lucky_draw_prize_code_id"
    t.index ["lucky_draw_prize_id"], name: "index_lucky_draws_on_lucky_draw_prize_id"
  end

  create_table "mp_images", force: :cascade do |t|
    t.string "name"
    t.integer "updated_by_id"
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mp_links", force: :cascade do |t|
    t.string "name"
    t.string "param"
    t.string "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_bundles", force: :cascade do |t|
    t.bigint "product_sku_id"
    t.bigint "product_bundle_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shipping_number"
    t.integer "quantity", default: 0
    t.string "shipping_company", default: "SF"
    t.index ["order_id"], name: "index_order_bundles_on_order_id"
    t.index ["product_bundle_id"], name: "index_order_bundles_on_product_bundle_id"
    t.index ["product_sku_id"], name: "index_order_bundles_on_product_sku_id"
  end

  create_table "order_coupons", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "coupon_id"
    t.bigint "product_sku_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coupon_id"], name: "index_order_coupons_on_coupon_id"
    t.index ["order_id"], name: "index_order_coupons_on_order_id"
    t.index ["product_sku_id"], name: "index_order_coupons_on_product_sku_id"
  end

  create_table "order_gift_cards", force: :cascade do |t|
    t.string "to"
    t.text "content"
    t.string "from"
    t.bigint "gift_card_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gift_card_id"], name: "index_order_gift_cards_on_gift_card_id"
    t.index ["order_id"], name: "index_order_gift_cards_on_order_id"
  end

  create_table "order_logistics", force: :cascade do |t|
    t.bigint "order_id"
    t.string "shipping_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_logistics_on_order_id"
  end

  create_table "order_package_skus", force: :cascade do |t|
    t.bigint "order_package_id"
    t.bigint "product_sku_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price", default: 0.0
    t.integer "quantity", default: 1
    t.index ["order_package_id"], name: "index_order_package_skus_on_order_package_id"
    t.index ["product_sku_id"], name: "index_order_package_skus_on_product_sku_id"
  end

  create_table "order_packages", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_package_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 1
    t.index ["order_id"], name: "index_order_packages_on_order_id"
    t.index ["product_package_id"], name: "index_order_packages_on_product_package_id"
  end

  create_table "order_payments", force: :cascade do |t|
    t.bigint "order_id"
    t.integer "status"
    t.text "error"
    t.jsonb "data"
    t.string "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "payment_type", default: 0
    t.index ["order_id"], name: "index_order_payments_on_order_id"
  end

  create_table "order_skus", force: :cascade do |t|
    t.bigint "product_sku_id"
    t.integer "quantity", default: 1
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shipping_number"
    t.string "shipping_company", default: "SF"
    t.float "price", default: 0.0
    t.index ["order_id"], name: "index_order_skus_on_order_id"
    t.index ["product_sku_id"], name: "index_order_skus_on_product_sku_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "customer_id"
    t.integer "order_number"
    t.integer "status", default: 0
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "province"
    t.string "city"
    t.string "address"
    t.string "area"
    t.boolean "need_invoice"
    t.string "name"
    t.integer "zip"
    t.string "mobile"
    t.string "invoice_title"
    t.string "tax_number"
    t.string "email"
    t.boolean "has_gift_message", default: false
    t.string "shipping_company", default: "SF"
    t.boolean "is_synced", default: false
    t.boolean "need_trial"
    t.bigint "douyin_customer_id"
    t.integer "source", default: 0
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["douyin_customer_id"], name: "index_orders_on_douyin_customer_id"
  end

  create_table "package_subscriptions", force: :cascade do |t|
    t.bigint "product_package_id"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_package_subscriptions_on_customer_id"
    t.index ["product_package_id"], name: "index_package_subscriptions_on_product_package_id"
  end

  create_table "page_block_products", force: :cascade do |t|
    t.bigint "page_block_id"
    t.bigint "product_sku_id"
    t.integer "ordering"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_type"
    t.bigint "product_package_id"
    t.index ["page_block_id"], name: "index_page_block_products_on_page_block_id"
    t.index ["product_package_id"], name: "index_page_block_products_on_product_package_id"
    t.index ["product_sku_id"], name: "index_page_block_products_on_product_sku_id"
  end

  create_table "page_block_slide_translations", force: :cascade do |t|
    t.bigint "page_block_slide_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.string "alt"
    t.index ["locale"], name: "index_page_block_slide_translations_on_locale"
    t.index ["page_block_slide_id"], name: "index_5f1ab10fd29b01f15f8d5412209d85590bb32373"
  end

  create_table "page_block_slides", force: :cascade do |t|
    t.bigint "page_block_id"
    t.string "title"
    t.text "description"
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.string "alt"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ordering"
    t.string "link"
    t.bigint "mp_link_id"
    t.bigint "product_id"
    t.bigint "product_package_id"
    t.bigint "campaign_id"
    t.bigint "product_sku_id"
    t.integer "link_type"
    t.integer "page_id"
    t.string "mp_name"
    t.index ["campaign_id"], name: "index_page_block_slides_on_campaign_id"
    t.index ["mp_link_id"], name: "index_page_block_slides_on_mp_link_id"
    t.index ["page_block_id"], name: "index_page_block_slides_on_page_block_id"
    t.index ["product_id"], name: "index_page_block_slides_on_product_id"
    t.index ["product_package_id"], name: "index_page_block_slides_on_product_package_id"
    t.index ["product_sku_id"], name: "index_page_block_slides_on_product_sku_id"
  end

  create_table "page_block_tabbars", force: :cascade do |t|
    t.bigint "page_block_id"
    t.integer "target"
    t.string "anchor_hover_file_name"
    t.string "anchor_hover_content_type"
    t.bigint "anchor_hover_file_size"
    t.datetime "anchor_hover_updated_at"
    t.string "anchor_active_file_name"
    t.string "anchor_active_content_type"
    t.bigint "anchor_active_file_size"
    t.datetime "anchor_active_updated_at"
    t.integer "ordering"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_block_id"], name: "index_page_block_tabbars_on_page_block_id"
  end

  create_table "page_block_translations", force: :cascade do |t|
    t.bigint "page_block_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.index ["locale"], name: "index_page_block_translations_on_locale"
    t.index ["page_block_id"], name: "index_page_block_translations_on_page_block_id"
  end

  create_table "page_blocks", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.text "description"
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.integer "template"
    t.bigint "page_id"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.integer "ordering"
    t.string "link"
    t.boolean "has_dots"
    t.boolean "has_arrows"
    t.string "height"
    t.boolean "sticky"
    t.float "link_width"
    t.float "link_height"
    t.index ["page_id"], name: "index_page_blocks_on_page_id"
  end

  create_table "pages", force: :cascade do |t|
    t.integer "template"
    t.string "name"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.string "slug"
  end

  create_table "product_blocks", force: :cascade do |t|
    t.bigint "product_id"
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.string "video_file_name"
    t.string "video_content_type"
    t.bigint "video_file_size"
    t.datetime "video_updated_at"
    t.float "x_position"
    t.float "y_position"
    t.float "link_width"
    t.float "link_height"
    t.integer "template"
    t.integer "ordering"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
    t.index ["product_id"], name: "index_product_blocks_on_product_id"
  end

  create_table "product_bundle_translations", force: :cascade do |t|
    t.bigint "product_bundle_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["locale"], name: "index_product_bundle_translations_on_locale"
    t.index ["product_bundle_id"], name: "index_product_bundle_translations_on_product_bundle_id"
  end

  create_table "product_bundles", force: :cascade do |t|
    t.string "name"
    t.integer "condition"
    t.float "price"
    t.float "price_condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.integer "quantity"
    t.boolean "status"
    t.integer "ordering"
    t.index ["product_id"], name: "index_product_bundles_on_product_id"
  end

  create_table "product_bundles_gift_skus", force: :cascade do |t|
    t.bigint "product_bundle_id"
    t.bigint "product_sku_id"
    t.index ["product_bundle_id"], name: "index_product_bundles_gift_skus_on_product_bundle_id"
    t.index ["product_sku_id"], name: "index_product_bundles_gift_skus_on_product_sku_id"
  end

  create_table "product_bundles_product_skus", id: :serial, force: :cascade do |t|
    t.bigint "product_sku_id", null: false
    t.bigint "product_bundle_id", null: false
    t.integer "quantity"
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "name"
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_sample", default: false
    t.integer "ordering"
    t.boolean "publish", default: true
  end

  create_table "product_category_translations", force: :cascade do |t|
    t.bigint "product_category_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["locale"], name: "index_product_category_translations_on_locale"
    t.index ["product_category_id"], name: "index_940eb7bce017e5d2b5e52716d9d421da1466d85c"
  end

  create_table "product_package_blocks", force: :cascade do |t|
    t.bigint "product_package_id"
    t.integer "template"
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.string "video_file_name"
    t.string "video_content_type"
    t.bigint "video_file_size"
    t.datetime "video_updated_at"
    t.string "link"
    t.float "x_position"
    t.float "y_position"
    t.float "link_width"
    t.float "link_height"
    t.integer "ordering"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_package_id"], name: "index_product_package_blocks_on_product_package_id"
  end

  create_table "product_package_product_skus", id: :serial, force: :cascade do |t|
    t.bigint "product_package_product_id", null: false
    t.bigint "product_sku_id", null: false
  end

  create_table "product_package_products", id: :serial, force: :cascade do |t|
    t.bigint "product_package_id", null: false
    t.bigint "product_id", null: false
  end

  create_table "product_package_trails", force: :cascade do |t|
    t.bigint "product_package_id"
    t.datetime "trial_start_date"
    t.datetime "trial_end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_package_id"], name: "index_product_package_trails_on_product_package_id"
  end

  create_table "product_package_translations", force: :cascade do |t|
    t.bigint "product_package_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "description"
    t.string "note"
    t.string "composition"
    t.index ["locale"], name: "index_product_package_translations_on_locale"
    t.index ["product_package_id"], name: "index_product_package_translations_on_product_package_id"
  end

  create_table "product_packages", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "note"
    t.boolean "star_product"
    t.integer "updated_by_id"
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.integer "ordering"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sku"
    t.integer "quantity"
    t.float "price"
    t.boolean "publish"
    t.boolean "hidden_product"
    t.bigint "product_category_id"
    t.string "composition"
    t.float "shipping_price"
    t.bigint "page_id"
    t.index ["page_id"], name: "index_product_packages_on_page_id"
    t.index ["product_category_id"], name: "index_product_packages_on_product_category_id"
  end

  create_table "product_product_attribute_categories", id: :bigint, default: -> { "nextval('product_attribute_categories_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "name"
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.bigint "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_product_attribute_category_translations", id: :bigint, default: -> { "nextval('product_attribute_category_translations_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "product_product_attribute_category_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["locale"], name: "index_f98c887c31123404209651f47d55edec0f64a392"
    t.index ["product_product_attribute_category_id"], name: "index_a6158515f3b83e9bdaec085f5454f3242907a991"
  end

  create_table "product_product_attribute_translations", id: :bigint, default: -> { "nextval('product_attribute_translations_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "product_product_attribute_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "composition"
    t.text "description"
    t.index ["locale"], name: "index_product_attribute_translations_on_locale"
    t.index ["product_product_attribute_id"], name: "index_b3ec89c2c7de4b70ca7863fe1890c8e0b42c6c7a"
  end

  create_table "product_product_attributes", id: :bigint, default: -> { "nextval('product_attributes_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "name"
    t.string "composition"
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.bigint "picture_file_size"
    t.datetime "picture_updated_at"
    t.bigint "product_product_attribute_category_id"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["product_product_attribute_category_id"], name: "product_attribute_and_category_index"
  end

  create_table "product_product_attributes_skus", id: :serial, force: :cascade do |t|
    t.bigint "product_product_attribute_id", null: false
    t.bigint "product_sku_id", null: false
    t.integer "sorting"
  end

  create_table "product_sku_limits", force: :cascade do |t|
    t.bigint "product_sku_id"
    t.datetime "limit_start_date"
    t.datetime "limit_end_date"
    t.integer "quantity"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_sku_id"], name: "index_product_sku_limits_on_product_sku_id"
  end

  create_table "product_sku_translations", force: :cascade do |t|
    t.bigint "product_sku_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "currency"
    t.text "description"
    t.text "composition"
    t.string "name"
    t.index ["locale"], name: "index_product_sku_translations_on_locale"
    t.index ["product_sku_id"], name: "index_product_sku_translations_on_product_sku_id"
  end

  create_table "product_skus", force: :cascade do |t|
    t.float "price", default: 0.0
    t.bigint "product_id"
    t.float "shipping_price"
    t.integer "currency"
    t.text "description"
    t.text "composition"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sku", null: false
    t.string "d1m_sku"
    t.string "name"
    t.integer "quantity", default: 0
    t.integer "ordering"
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.integer "douyin_quantity", default: 0
    t.boolean "limited_product", default: false
    t.index ["product_id"], name: "index_product_skus_on_product_id"
    t.index ["sku"], name: "index_product_skus_on_sku"
  end

  create_table "product_translations", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "note"
    t.string "composition"
    t.text "description"
    t.index ["locale"], name: "index_product_translations_on_locale"
    t.index ["product_id"], name: "index_product_translations_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "description"
    t.string "name"
    t.string "note"
    t.string "composition"
    t.bigint "product_category_id"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.integer "ordering"
    t.boolean "star_product"
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
  end

  create_table "seo_translations", force: :cascade do |t|
    t.bigint "seo_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "meta_keywords"
    t.text "meta_description"
    t.string "meta_title"
    t.index ["locale"], name: "index_seo_translations_on_locale"
    t.index ["seo_id"], name: "index_seo_translations_on_seo_id"
  end

  create_table "seos", force: :cascade do |t|
    t.string "slug"
    t.string "meta_keywords"
    t.text "meta_description"
    t.string "meta_title"
    t.integer "seoable_id"
    t.string "seoable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sms_verifications", force: :cascade do |t|
    t.string "phone"
    t.integer "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expired_at"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "phone"
    t.bigint "user_role_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["user_role_id"], name: "index_users_on_user_role_id"
  end

  add_foreign_key "attachments", "users", column: "created_by_id"
  add_foreign_key "attachments", "users", column: "updated_by_id"
  add_foreign_key "campaign_blocks", "campaigns"
  add_foreign_key "campaign_blocks", "mp_links"
  add_foreign_key "campaign_blocks", "product_packages"
  add_foreign_key "campaign_blocks", "products"
  add_foreign_key "country_provinces", "countries"
  add_foreign_key "coupon_product_skus", "coupons"
  add_foreign_key "coupon_product_skus", "product_skus"
  add_foreign_key "customer_tokens", "customers"
  add_foreign_key "douyin_customer_tokens", "douyin_customers"
  add_foreign_key "lucky_draw_prize_codes", "coupons"
  add_foreign_key "lucky_draw_prize_codes", "lucky_draw_prizes"
  add_foreign_key "lucky_draw_prizes", "product_packages"
  add_foreign_key "lucky_draws", "customers"
  add_foreign_key "lucky_draws", "lucky_draw_prize_codes"
  add_foreign_key "lucky_draws", "lucky_draw_prizes"
  add_foreign_key "order_bundles", "orders"
  add_foreign_key "order_bundles", "product_bundles"
  add_foreign_key "order_bundles", "product_skus"
  add_foreign_key "order_coupons", "coupons"
  add_foreign_key "order_coupons", "orders"
  add_foreign_key "order_coupons", "product_skus"
  add_foreign_key "order_gift_cards", "gift_cards"
  add_foreign_key "order_gift_cards", "orders"
  add_foreign_key "order_logistics", "orders"
  add_foreign_key "order_package_skus", "order_packages"
  add_foreign_key "order_package_skus", "product_skus"
  add_foreign_key "order_packages", "orders"
  add_foreign_key "order_packages", "product_packages"
  add_foreign_key "order_payments", "orders"
  add_foreign_key "order_skus", "orders"
  add_foreign_key "order_skus", "product_skus"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "douyin_customers"
  add_foreign_key "package_subscriptions", "customers"
  add_foreign_key "package_subscriptions", "product_packages"
  add_foreign_key "page_block_products", "page_blocks"
  add_foreign_key "page_block_products", "product_packages"
  add_foreign_key "page_block_products", "product_skus"
  add_foreign_key "page_block_products", "users", column: "created_by_id"
  add_foreign_key "page_block_products", "users", column: "updated_by_id"
  add_foreign_key "page_block_slides", "campaigns"
  add_foreign_key "page_block_slides", "mp_links"
  add_foreign_key "page_block_slides", "page_blocks"
  add_foreign_key "page_block_slides", "product_packages"
  add_foreign_key "page_block_slides", "product_skus"
  add_foreign_key "page_block_slides", "products"
  add_foreign_key "page_block_slides", "users", column: "created_by_id"
  add_foreign_key "page_block_slides", "users", column: "updated_by_id"
  add_foreign_key "page_block_tabbars", "page_blocks"
  add_foreign_key "page_block_tabbars", "users", column: "created_by_id"
  add_foreign_key "page_block_tabbars", "users", column: "updated_by_id"
  add_foreign_key "page_blocks", "pages"
  add_foreign_key "page_blocks", "users", column: "created_by_id"
  add_foreign_key "page_blocks", "users", column: "updated_by_id"
  add_foreign_key "pages", "users", column: "created_by_id"
  add_foreign_key "pages", "users", column: "updated_by_id"
  add_foreign_key "product_blocks", "products"
  add_foreign_key "product_bundles", "users", column: "created_by_id"
  add_foreign_key "product_bundles", "users", column: "updated_by_id"
  add_foreign_key "product_bundles_gift_skus", "product_bundles"
  add_foreign_key "product_bundles_gift_skus", "product_skus"
  add_foreign_key "product_categories", "users", column: "created_by_id"
  add_foreign_key "product_categories", "users", column: "updated_by_id"
  add_foreign_key "product_package_blocks", "product_packages"
  add_foreign_key "product_package_trails", "product_packages"
  add_foreign_key "product_packages", "pages"
  add_foreign_key "product_packages", "product_categories"
  add_foreign_key "product_packages", "users", column: "updated_by_id"
  add_foreign_key "product_product_attribute_categories", "users", column: "created_by_id"
  add_foreign_key "product_product_attribute_categories", "users", column: "updated_by_id"
  add_foreign_key "product_product_attributes", "product_product_attribute_categories"
  add_foreign_key "product_product_attributes", "users", column: "created_by_id"
  add_foreign_key "product_product_attributes", "users", column: "updated_by_id"
  add_foreign_key "product_sku_limits", "product_skus"
  add_foreign_key "product_sku_limits", "users", column: "created_by_id"
  add_foreign_key "product_sku_limits", "users", column: "updated_by_id"
  add_foreign_key "product_skus", "products"
  add_foreign_key "product_skus", "users", column: "created_by_id"
  add_foreign_key "product_skus", "users", column: "updated_by_id"
  add_foreign_key "products", "product_categories"
  add_foreign_key "products", "users", column: "created_by_id"
  add_foreign_key "products", "users", column: "updated_by_id"
  add_foreign_key "users", "user_roles"
end
