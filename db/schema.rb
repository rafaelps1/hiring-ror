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

ActiveRecord::Schema[7.0].define(version: 20_230_508_220_418) do
  create_table 'products', charset: 'utf8mb3', force: :cascade do |t|
    t.string 'name', limit: 100, null: false
    t.string 'title'
    t.decimal 'price', precision: 15, scale: 2, default: '0.0', null: false
    t.string 'photo', null: false
    t.boolean 'state', default: true
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_products_on_name'
    t.index ['user_id'], name: 'index_products_on_user_id'
  end

  create_table 'users', charset: 'utf8mb3', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'password_digest', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'products', 'users'
end
