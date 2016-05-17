class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string   :name, null: false
      t.text     :description, null: false
      t.integer  :price, null: false
      t.string   :email, null: false

      t.timestamps
    end
  end
end

