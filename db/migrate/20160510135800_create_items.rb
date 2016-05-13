class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string   :name, null: false, limit: 50
      t.text     :description, null: false, limit: 250
      t.integer  :price, null: false
      t.string   :email, null: false

      t.timestamps
    end
  end
end

