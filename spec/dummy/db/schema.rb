# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140518135713) do

  create_table "accepts", :force => true do |t|
    t.integer  "basket_id"
    t.integer  "item_id"
    t.integer  "librarian_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "accepts", ["basket_id"], :name => "index_accepts_on_basket_id"
  add_index "accepts", ["item_id"], :name => "index_accepts_on_item_id"

  create_table "agent_types", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "agents", :force => true do |t|
    t.integer  "user_id"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "first_name"
    t.string   "last_name_transcription"
    t.string   "middle_name_transcription"
    t.string   "first_name_transcription"
    t.string   "corporate_name"
    t.string   "corporate_name_transcription"
    t.string   "full_name"
    t.text     "full_name_transcription"
    t.text     "full_name_alternative"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.datetime "deleted_at"
    t.string   "zip_code_1"
    t.string   "zip_code_2"
    t.text     "address_1"
    t.text     "address_2"
    t.text     "address_1_note"
    t.text     "address_2_note"
    t.string   "telephone_number_1"
    t.string   "telephone_number_2"
    t.string   "fax_number_1"
    t.string   "fax_number_2"
    t.text     "other_designation"
    t.text     "place"
    t.string   "postal_code"
    t.text     "street"
    t.text     "locality"
    t.text     "region"
    t.datetime "date_of_birth"
    t.datetime "date_of_death"
    t.integer  "language_id",                  :default => 1, :null => false
    t.integer  "country_id",                   :default => 1, :null => false
    t.integer  "agent_type_id",                :default => 1, :null => false
    t.integer  "lock_version",                 :default => 0, :null => false
    t.text     "note"
    t.integer  "required_role_id",             :default => 1, :null => false
    t.integer  "required_score",               :default => 0, :null => false
    t.string   "state"
    t.text     "email"
    t.text     "url"
    t.string   "birth_date"
    t.string   "death_date"
  end

  add_index "agents", ["country_id"], :name => "index_agents_on_country_id"
  add_index "agents", ["full_name"], :name => "index_agents_on_full_name"
  add_index "agents", ["language_id"], :name => "index_agents_on_language_id"
  add_index "agents", ["required_role_id"], :name => "index_agents_on_required_role_id"
  add_index "agents", ["user_id"], :name => "index_agents_on_user_id", :unique => true

  create_table "baskets", :force => true do |t|
    t.integer  "user_id"
    t.text     "note"
    t.integer  "lock_version", :default => 0, :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "baskets", ["user_id"], :name => "index_baskets_on_user_id"

  create_table "bookstores", :force => true do |t|
    t.text     "name",             :null => false
    t.string   "zip_code"
    t.text     "address"
    t.text     "note"
    t.string   "telephone_number"
    t.string   "fax_number"
    t.string   "url"
    t.integer  "position"
    t.datetime "deleted_at"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "budget_types", :force => true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "countries", :force => true do |t|
    t.string  "name",         :null => false
    t.text    "display_name"
    t.string  "alpha_2"
    t.string  "alpha_3"
    t.string  "numeric_3"
    t.text    "note"
    t.integer "position"
  end

  add_index "countries", ["alpha_2"], :name => "index_countries_on_alpha_2"
  add_index "countries", ["alpha_3"], :name => "index_countries_on_alpha_3"
  add_index "countries", ["name"], :name => "index_countries_on_name"
  add_index "countries", ["numeric_3"], :name => "index_countries_on_numeric_3"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.string   "native_name"
    t.text     "display_name"
    t.string   "iso_639_1"
    t.string   "iso_639_2"
    t.string   "iso_639_3"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "libraries", :force => true do |t|
    t.string   "name",                                   :null => false
    t.text     "display_name"
    t.string   "short_display_name",                     :null => false
    t.string   "zip_code"
    t.text     "street"
    t.text     "locality"
    t.text     "region"
    t.string   "telephone_number_1"
    t.string   "telephone_number_2"
    t.string   "fax_number"
    t.text     "note"
    t.integer  "call_number_rows",      :default => 1,   :null => false
    t.string   "call_number_delimiter", :default => "|", :null => false
    t.integer  "library_group_id",      :default => 1,   :null => false
    t.integer  "users_count",           :default => 0,   :null => false
    t.integer  "position"
    t.integer  "country_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.datetime "deleted_at"
    t.text     "opening_hour"
    t.string   "isil"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "libraries", ["library_group_id"], :name => "index_libraries_on_library_group_id"
  add_index "libraries", ["name"], :name => "index_libraries_on_name", :unique => true

  create_table "library_groups", :force => true do |t|
    t.string   "name",                                                              :null => false
    t.text     "display_name"
    t.string   "short_name",                                                        :null => false
    t.string   "email"
    t.text     "my_networks"
    t.text     "login_banner"
    t.text     "note"
    t.integer  "country_id"
    t.integer  "position"
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
    t.text     "admin_networks"
    t.boolean  "allow_bookmark_external_url", :default => false,                    :null => false
    t.string   "url",                         :default => "http://localhost:3000/"
  end

  add_index "library_groups", ["short_name"], :name => "index_library_groups_on_short_name"

  create_table "message_request_transitions", :force => true do |t|
    t.string   "to_state"
    t.text     "metadata",           :default => "{}"
    t.integer  "sort_key"
    t.integer  "message_request_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "message_request_transitions", ["message_request_id"], :name => "index_message_request_transitions_on_message_request_id"
  add_index "message_request_transitions", ["sort_key", "message_request_id"], :name => "index_message_request_transitions_on_sort_key_and_request_id", :unique => true

  create_table "message_requests", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "message_template_id"
    t.datetime "sent_at"
    t.datetime "deleted_at"
    t.text     "body"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "message_templates", :force => true do |t|
    t.string   "status",                       :null => false
    t.text     "title",                        :null => false
    t.text     "body",                         :null => false
    t.integer  "position"
    t.string   "locale",     :default => "en"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "message_templates", ["status"], :name => "index_message_templates_on_status", :unique => true

  create_table "message_transitions", :force => true do |t|
    t.string   "to_state"
    t.text     "metadata",   :default => "{}"
    t.integer  "sort_key"
    t.integer  "message_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "message_transitions", ["message_id"], :name => "index_message_transitions_on_message_id"
  add_index "message_transitions", ["sort_key", "message_id"], :name => "index_message_transitions_on_sort_key_and_message_id", :unique => true

  create_table "messages", :force => true do |t|
    t.datetime "read_at"
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.string   "subject",            :null => false
    t.text     "body"
    t.integer  "message_request_id"
    t.integer  "parent_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
  end

  add_index "messages", ["message_request_id"], :name => "index_messages_on_message_request_id"
  add_index "messages", ["parent_id"], :name => "index_messages_on_parent_id"
  add_index "messages", ["receiver_id"], :name => "index_messages_on_receiver_id"
  add_index "messages", ["sender_id"], :name => "index_messages_on_sender_id"

  create_table "request_status_types", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "request_types", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "search_engines", :force => true do |t|
    t.string   "name",             :null => false
    t.text     "display_name"
    t.string   "url",              :null => false
    t.text     "base_url",         :null => false
    t.text     "http_method",      :null => false
    t.text     "query_param",      :null => false
    t.text     "additional_param"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "shelves", :force => true do |t|
    t.string   "name",                            :null => false
    t.text     "display_name"
    t.text     "note"
    t.integer  "library_id",   :default => 1,     :null => false
    t.integer  "items_count",  :default => 0,     :null => false
    t.integer  "position"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.datetime "deleted_at"
    t.boolean  "closed",       :default => false, :null => false
  end

  add_index "shelves", ["library_id"], :name => "index_shelves_on_library_id"

  create_table "subscribes", :force => true do |t|
    t.integer  "subscription_id", :null => false
    t.integer  "work_id",         :null => false
    t.datetime "start_at",        :null => false
    t.datetime "end_at",          :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "subscribes", ["subscription_id"], :name => "index_subscribes_on_subscription_id"
  add_index "subscribes", ["work_id"], :name => "index_subscribes_on_work_id"

  create_table "subscriptions", :force => true do |t|
    t.text     "title",                           :null => false
    t.text     "note"
    t.integer  "user_id"
    t.integer  "order_list_id"
    t.datetime "deleted_at"
    t.integer  "subscribes_count", :default => 0, :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "subscriptions", ["order_list_id"], :name => "index_subscriptions_on_order_list_id"
  add_index "subscriptions", ["user_id"], :name => "index_subscriptions_on_user_id"

  create_table "user_groups", :force => true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.datetime "deleted_at"
    t.integer  "valid_period_for_new_user", :default => 0, :null => false
    t.datetime "expired_at"
  end

  create_table "user_has_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
    t.string   "user_number"
    t.string   "state"
    t.string   "locale"
    t.datetime "deleted_at"
    t.datetime "expired_at"
    t.integer  "library_id",             :default => 1,  :null => false
    t.integer  "required_role_id",       :default => 1,  :null => false
    t.integer  "user_group_id",          :default => 1,  :null => false
    t.text     "note"
    t.text     "keyword_list"
    t.integer  "failed_attempts"
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "confirmed_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true
  add_index "users", ["user_group_id"], :name => "index_users_on_user_group_id"
  add_index "users", ["user_number"], :name => "index_users_on_user_number", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
