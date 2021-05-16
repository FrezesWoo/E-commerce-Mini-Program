class RemoveFieldsFromOrder < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :gift_to_user
    remove_column :orders, :gift_from_user
    remove_column :orders, :gift_message
  end
end
