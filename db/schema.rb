ActiveRecord::Schema.define(version: 20160511124800) do

  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string   "name",        limit: 50, null: false
    t.text     "description",            null: false
    t.integer  "price",                  null: false
    t.string   "email",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

end
