# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_28_001845) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_admins_on_company_id"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "qr_code"
    t.string "summary"
  end

  create_table "companies_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.index ["company_id", "user_id"], name: "index_companies_users_on_company_id_and_user_id"
    t.index ["user_id", "company_id"], name: "index_companies_users_on_user_id_and_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "summary"
    t.string "resume_link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "resume"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "admins", "companies"

  create_function :refresh_company_to_user_view, sql_definition: <<-SQL
      CREATE OR REPLACE FUNCTION public.refresh_company_to_user_view()
       RETURNS trigger
       LANGUAGE plpgsql
      AS $function$
      BEGIN
        REFRESH MATERIALIZED VIEW company_to_users;
        RETURN NULL;
      END;
      $function$
  SQL
  create_function :refresh_user_to_company_view, sql_definition: <<-SQL
      CREATE OR REPLACE FUNCTION public.refresh_user_to_company_view()
       RETURNS trigger
       LANGUAGE plpgsql
      AS $function$
      BEGIN
        REFRESH MATERIALIZED VIEW user_to_companies;
        RETURN NULL;
      END;
      $function$
  SQL

  create_trigger :refresh_company_to_user_view, sql_definition: <<-SQL
      CREATE TRIGGER refresh_company_to_user_view AFTER INSERT OR DELETE OR UPDATE ON public.companies_users FOR EACH STATEMENT EXECUTE PROCEDURE refresh_company_to_user_view()
  SQL
  create_trigger :refresh_user_to_company_view, sql_definition: <<-SQL
      CREATE TRIGGER refresh_user_to_company_view AFTER INSERT OR DELETE OR UPDATE ON public.companies_users FOR EACH STATEMENT EXECUTE PROCEDURE refresh_user_to_company_view()
  SQL

  create_view "company_to_users", materialized: true, sql_definition: <<-SQL
      SELECT companies_users.company_id,
      users.id,
      users.email,
      users.encrypted_password,
      users.reset_password_token,
      users.reset_password_sent_at,
      users.remember_created_at,
      users.username,
      users.first_name,
      users.last_name,
      users.summary,
      users.resume_link,
      users.created_at,
      users.updated_at,
      users.resume
     FROM (companies_users
       JOIN users ON ((companies_users.user_id = users.id)));
  SQL
  add_index "company_to_users", ["company_id"], name: "index_company_to_users_on_company_id"

  create_view "user_to_companies", materialized: true, sql_definition: <<-SQL
      SELECT companies_users.user_id,
      companies.name
     FROM (companies_users
       JOIN companies ON ((companies_users.company_id = companies.id)));
  SQL
  add_index "user_to_companies", ["user_id"], name: "index_user_to_companies_on_user_id"

end
