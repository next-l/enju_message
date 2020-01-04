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

ActiveRecord::Schema.define(version: 2019_12_16_131755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "accepts", force: :cascade do |t|
    t.bigint "basket_id"
    t.bigint "item_id"
    t.bigint "librarian_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["basket_id"], name: "index_accepts_on_basket_id"
    t.index ["item_id"], name: "index_accepts_on_item_id"
    t.index ["librarian_id"], name: "index_accepts_on_librarian_id"
  end

  create_table "baskets", force: :cascade do |t|
    t.bigint "user_id"
    t.text "note"
    t.integer "lock_version", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_baskets_on_user_id"
  end

  create_table "bookstores", force: :cascade do |t|
    t.text "name", null: false
    t.string "zip_code"
    t.text "address"
    t.text "note"
    t.string "telephone_number"
    t.string "fax_number"
    t.string "url"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "budget_types", force: :cascade do |t|
    t.string "name"
    t.text "display_name"
    t.text "note"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "display_name_translations", default: {}, null: false
  end

  create_table "colors", force: :cascade do |t|
    t.bigint "library_group_id"
    t.string "property"
    t.string "code"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["library_group_id"], name: "index_colors_on_library_group_id"
  end

  create_table "languages", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "native_name"
    t.text "display_name"
    t.string "iso_639_1"
    t.string "iso_639_2"
    t.string "iso_639_3"
    t.text "note"
    t.integer "position"
    t.index ["iso_639_1"], name: "index_languages_on_iso_639_1"
    t.index ["iso_639_2"], name: "index_languages_on_iso_639_2"
    t.index ["iso_639_3"], name: "index_languages_on_iso_639_3"
    t.index ["name"], name: "index_languages_on_name", unique: true
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name", null: false
    t.text "display_name"
    t.string "short_display_name", null: false
    t.string "zip_code"
    t.text "street"
    t.text "locality"
    t.text "region"
    t.string "telephone_number_1"
    t.string "telephone_number_2"
    t.string "fax_number"
    t.text "note"
    t.integer "call_number_rows", default: 1, null: false
    t.string "call_number_delimiter", default: "|", null: false
    t.bigint "library_group_id", null: false
    t.integer "users_count", default: 0, null: false
    t.integer "position"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "opening_hour"
    t.string "isil"
    t.float "latitude"
    t.float "longitude"
    t.jsonb "display_name_translations", default: {}, null: false
    t.index ["country_id"], name: "index_libraries_on_country_id"
    t.index ["library_group_id"], name: "index_libraries_on_library_group_id"
    t.index ["name"], name: "index_libraries_on_name"
  end

  create_table "library_groups", force: :cascade do |t|
    t.string "name", null: false
    t.text "display_name"
    t.string "short_name", null: false
    t.text "my_networks"
    t.text "old_login_banner"
    t.text "note"
    t.integer "country_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "admin_networks"
    t.string "url", default: "http://localhost:3000/"
    t.text "settings"
    t.text "html_snippet"
    t.integer "max_number_of_results", default: 500
    t.boolean "family_name_first", default: true
    t.integer "pub_year_facet_range_interval", default: 10
    t.bigint "user_id"
    t.boolean "csv_charset_conversion", default: false, null: false
    t.string "header_logo_file_name"
    t.string "header_logo_content_type"
    t.bigint "header_logo_file_size"
    t.datetime "header_logo_updated_at"
    t.text "header_logo_meta"
    t.jsonb "display_name_translations", default: {}, null: false
    t.jsonb "login_banner_translations", default: {}, null: false
    t.jsonb "footer_banner_translations", default: {}, null: false
    t.string "email"
    t.index ["email"], name: "index_library_groups_on_email"
    t.index ["short_name"], name: "index_library_groups_on_short_name"
    t.index ["user_id"], name: "index_library_groups_on_user_id"
  end

  create_table "message_request_transitions", force: :cascade do |t|
    t.string "to_state"
    t.text "metadata", default: "{}"
    t.integer "sort_key"
    t.integer "message_request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "most_recent", null: false
    t.index ["message_request_id", "most_recent"], name: "index_message_request_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["message_request_id"], name: "index_message_request_transitions_on_message_request_id"
    t.index ["sort_key", "message_request_id"], name: "index_message_request_transitions_on_sort_key_and_request_id", unique: true
  end

  create_table "message_requests", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.bigint "message_template_id"
    t.datetime "sent_at"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_template_id"], name: "index_message_requests_on_message_template_id"
    t.index ["receiver_id"], name: "index_message_requests_on_receiver_id"
    t.index ["sender_id"], name: "index_message_requests_on_sender_id"
  end

  create_table "message_templates", force: :cascade do |t|
    t.string "status", null: false
    t.text "title", null: false
    t.text "body", null: false
    t.integer "position"
    t.string "locale", default: "en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_message_templates_on_status", unique: true
  end

  create_table "message_transitions", force: :cascade do |t|
    t.string "to_state"
    t.text "metadata", default: "{}"
    t.integer "sort_key"
    t.integer "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "most_recent", null: false
    t.index ["message_id", "most_recent"], name: "index_message_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["message_id"], name: "index_message_transitions_on_message_id"
    t.index ["sort_key", "message_id"], name: "index_message_transitions_on_sort_key_and_message_id", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.datetime "read_at"
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.string "subject", null: false
    t.text "body"
    t.bigint "message_request_id"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.index ["message_request_id"], name: "index_messages_on_message_request_id"
    t.index ["parent_id"], name: "index_messages_on_parent_id"
    t.index ["receiver_id"], name: "index_messages_on_receiver_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "user_group_id"
    t.bigint "library_id"
    t.string "locale"
    t.string "user_number"
    t.text "full_name"
    t.text "note"
    t.text "keyword_list"
    t.bigint "required_role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expired_at"
    t.text "full_name_transcription"
    t.datetime "date_of_birth"
    t.jsonb "full_name_translations", default: {}, null: false
    t.index ["library_id"], name: "index_profiles_on_library_id"
    t.index ["user_group_id"], name: "index_profiles_on_user_group_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
    t.index ["user_number"], name: "index_profiles_on_user_number", unique: true
  end

  create_table "request_status_types", force: :cascade do |t|
    t.string "name", null: false
    t.text "display_name"
    t.text "note"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "display_name_translations", default: {}, null: false
  end

  create_table "request_types", force: :cascade do |t|
    t.string "name", null: false
    t.text "display_name"
    t.text "note"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "display_name_translations", default: {}, null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.string "display_name"
    t.text "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "score", default: 0, null: false
    t.integer "position"
    t.jsonb "display_name_translations", default: {}, null: false
  end

  create_table "search_engines", force: :cascade do |t|
    t.string "name", null: false
    t.text "display_name"
    t.string "url", null: false
    t.text "base_url", null: false
    t.text "http_method", null: false
    t.text "query_param", null: false
    t.text "additional_param"
    t.text "note"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "display_name_translations", default: {}, null: false
  end

  create_table "shelves", force: :cascade do |t|
    t.string "name", null: false
    t.text "display_name"
    t.text "note"
    t.bigint "library_id", null: false
    t.integer "items_count", default: 0, null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "closed", default: false, null: false
    t.jsonb "display_name_translations", default: {}, null: false
    t.index ["library_id"], name: "index_shelves_on_library_id"
  end

  create_table "subscribes", force: :cascade do |t|
    t.bigint "subscription_id", null: false
    t.integer "work_id", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_id"], name: "index_subscribes_on_subscription_id"
    t.index ["work_id"], name: "index_subscribes_on_work_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.text "title", null: false
    t.text "note"
    t.bigint "user_id"
    t.bigint "order_list_id"
    t.integer "subscribes_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_list_id"], name: "index_subscriptions_on_order_list_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "user_export_file_transitions", force: :cascade do |t|
    t.string "to_state"
    t.text "metadata", default: "{}"
    t.integer "sort_key"
    t.bigint "user_export_file_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "most_recent", null: false
    t.index ["sort_key", "user_export_file_id"], name: "index_user_export_file_transitions_on_sort_key_and_file_id", unique: true
    t.index ["user_export_file_id", "most_recent"], name: "index_user_export_file_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["user_export_file_id"], name: "index_user_export_file_transitions_on_file_id"
    t.index ["user_export_file_id"], name: "index_user_export_file_transitions_on_user_export_file_id"
  end

  create_table "user_export_files", force: :cascade do |t|
    t.bigint "user_id"
    t.string "user_export_file_name"
    t.string "user_export_content_type"
    t.bigint "user_export_file_size"
    t.datetime "user_export_updated_at"
    t.datetime "executed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_export_files_on_user_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.string "name"
    t.text "display_name"
    t.text "note"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "valid_period_for_new_user", default: 0, null: false
    t.datetime "expired_at"
    t.jsonb "display_name_translations", default: {}, null: false
  end

  create_table "user_has_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_has_roles_on_role_id"
    t.index ["user_id"], name: "index_user_has_roles_on_user_id"
  end

  create_table "user_import_file_transitions", force: :cascade do |t|
    t.string "to_state"
    t.text "metadata", default: "{}"
    t.integer "sort_key"
    t.bigint "user_import_file_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "most_recent", null: false
    t.index ["sort_key", "user_import_file_id"], name: "index_user_import_file_transitions_on_sort_key_and_file_id", unique: true
    t.index ["user_import_file_id", "most_recent"], name: "index_user_import_file_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["user_import_file_id"], name: "index_user_import_file_transitions_on_user_import_file_id"
  end

  create_table "user_import_files", force: :cascade do |t|
    t.bigint "user_id"
    t.text "note"
    t.datetime "executed_at"
    t.string "user_import_file_name"
    t.string "user_import_content_type"
    t.integer "user_import_file_size"
    t.datetime "user_import_updated_at"
    t.string "user_import_fingerprint"
    t.string "edit_mode"
    t.text "error_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_encoding"
    t.bigint "default_library_id"
    t.bigint "default_user_group_id"
    t.index ["default_library_id"], name: "index_user_import_files_on_default_library_id"
    t.index ["default_user_group_id"], name: "index_user_import_files_on_default_user_group_id"
    t.index ["user_id"], name: "index_user_import_files_on_user_id"
  end

  create_table "user_import_results", force: :cascade do |t|
    t.bigint "user_import_file_id"
    t.bigint "user_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "error_message"
    t.index ["user_id"], name: "index_user_import_results_on_user_id"
    t.index ["user_import_file_id"], name: "index_user_import_results_on_user_import_file_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.datetime "expired_at"
    t.integer "failed_attempts", default: 0
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "confirmed_at"
    t.bigint "profile_id"
    t.index ["email"], name: "index_users_on_email"
    t.index ["profile_id"], name: "index_users_on_profile_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "withdraws", force: :cascade do |t|
    t.bigint "basket_id"
    t.bigint "item_id"
    t.bigint "librarian_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["basket_id"], name: "index_withdraws_on_basket_id"
    t.index ["item_id"], name: "index_withdraws_on_item_id"
    t.index ["librarian_id"], name: "index_withdraws_on_librarian_id"
  end

  add_foreign_key "libraries", "library_groups"
  add_foreign_key "library_groups", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "user_has_roles", "roles"
  add_foreign_key "user_has_roles", "users"
  add_foreign_key "users", "profiles"
end
