class RemoveEmailFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :email, :string
  end
end
