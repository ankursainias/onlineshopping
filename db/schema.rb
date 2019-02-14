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

ActiveRecord::Schema.define(version: 2019_02_12_082349) do

  create_table "brand_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "brand_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_brand_categories_on_brand_id"
    t.index ["category_id"], name: "index_brand_categories_on_category_id"
  end

  create_table "brands", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "gateway_card_id"
    t.string "exp_month"
    t.string "exp_year"
    t.string "last4"
    t.string "card_type"
    t.boolean "default", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "fingerprint"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "cart_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "cart_id"
    t.bigint "user_id"
    t.bigint "item_id"
    t.integer "quantity", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "item_dimension_id"
    t.text "less_ingredient_ids"
    t.text "topping_ids"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["item_dimension_id"], name: "index_cart_items_on_item_dimension_id"
    t.index ["item_id"], name: "index_cart_items_on_item_id"
    t.index ["user_id"], name: "index_cart_items_on_user_id"
  end

  create_table "carts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "session_id", default: ""
    t.bigint "user_id"
    t.boolean "purchased", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_ingredients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "ingredient_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_ingredients_on_category_id"
    t.index ["ingredient_id"], name: "index_category_ingredients_on_ingredient_id"
  end

  create_table "coupon_redemptions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "coupon_id", null: false
    t.bigint "user_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coupon_id"], name: "index_coupon_redemptions_on_coupon_id"
    t.index ["order_id"], name: "index_coupon_redemptions_on_order_id"
    t.index ["user_id"], name: "index_coupon_redemptions_on_user_id"
  end

  create_table "coupons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code", null: false
    t.string "description"
    t.date "valid_from", null: false
    t.date "valid_until"
    t.integer "redemption_limit", default: 1, null: false
    t.integer "coupon_redemptions_count", default: 0, null: false
    t.float "amount", default: 0.0, null: false
    t.string "c_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "attachments"
  end

  create_table "deal_items", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "deal_id"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_deal_items_on_deal_id"
    t.index ["item_id"], name: "index_deal_items_on_item_id"
  end

  create_table "deals", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "price_id"
    t.string "name"
    t.float "amount", default: 0.0
    t.string "image"
    t.datetime "initial_time"
    t.datetime "end_time"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["price_id"], name: "index_deals_on_price_id"
  end

  create_table "delivery_addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "session_id"
    t.string "line1"
    t.string "line2"
    t.string "house_no"
    t.string "city"
    t.integer "postal_code"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.string "other"
    t.boolean "is_default", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.index ["user_id"], name: "index_delivery_addresses_on_user_id"
  end

  create_table "dimensions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "size", default: "Personal"
    t.integer "serve", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_dimensions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "dimension_id"
    t.float "price", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dimension_id"], name: "index_item_dimensions_on_dimension_id"
    t.index ["item_id"], name: "index_item_dimensions_on_item_id"
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_items_on_category_id"
  end

  create_table "open_hours", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "store_id"
    t.integer "day"
    t.time "close"
    t.time "open"
    t.datetime "valid_from"
    t.datetime "valid_through"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_open_hours_on_store_id"
  end

  create_table "order_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "order_status_id"
    t.datetime "expected_delivery_at"
    t.datetime "cancelled_at"
    t.bigint "cart_id"
    t.float "delivery_fee", default: 0.0
    t.float "sub_total", default: 0.0
    t.float "discount_total", default: 0.0
    t.float "grand_total", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "delivery_address_id"
    t.bigint "store_id"
    t.index ["cart_id"], name: "index_orders_on_cart_id"
    t.index ["delivery_address_id"], name: "index_orders_on_delivery_address_id"
    t.index ["order_status_id"], name: "index_orders_on_order_status_id"
    t.index ["store_id"], name: "index_orders_on_store_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_id"
    t.string "transaction_id"
    t.datetime "pay_time"
    t.bigint "card_id"
    t.string "failure_message"
    t.string "failure_code"
    t.string "gateway_status"
    t.boolean "captrued", default: false
    t.string "pay_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "fee", default: 0.0
    t.string "currency", default: "INR"
    t.string "payer_id"
    t.string "token"
    t.boolean "completed", default: false
    t.index ["card_id"], name: "index_payments_on_card_id"
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "pictures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "imageable_type"
    t.bigint "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id"
  end

  create_table "prices", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "title"
    t.string "p_type"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "store_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "store_id"
    t.bigint "item_id"
    t.boolean "out_of_stock", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_store_items_on_item_id"
    t.index ["store_id"], name: "index_store_items_on_store_id"
  end

  create_table "stores", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "postal_code"
    t.string "city"
    t.string "phone"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "store_items_count", default: 0
  end

  create_table "toppings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.float "price", default: 0.0
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "gateway_customer_id"
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "brand_categories", "brands"
  add_foreign_key "brand_categories", "categories"
  add_foreign_key "cards", "users"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "item_dimensions"
  add_foreign_key "cart_items", "items"
  add_foreign_key "cart_items", "users"
  add_foreign_key "carts", "users"
  add_foreign_key "category_ingredients", "categories"
  add_foreign_key "category_ingredients", "ingredients"
  add_foreign_key "deal_items", "deals"
  add_foreign_key "deal_items", "items"
  add_foreign_key "deals", "prices"
  add_foreign_key "delivery_addresses", "users"
  add_foreign_key "item_dimensions", "dimensions"
  add_foreign_key "item_dimensions", "items"
  add_foreign_key "open_hours", "stores"
  add_foreign_key "orders", "carts"
  add_foreign_key "orders", "delivery_addresses"
  add_foreign_key "orders", "order_statuses"
  add_foreign_key "orders", "stores"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "cards"
  add_foreign_key "payments", "orders"
  add_foreign_key "store_items", "items"
  add_foreign_key "store_items", "stores"
end
