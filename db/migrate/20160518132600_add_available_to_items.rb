class AddAvailableToItems < ActiveRecord::Migration
  def change
    add_column :items, :available, :bool, default: true, null: false
  end
end
