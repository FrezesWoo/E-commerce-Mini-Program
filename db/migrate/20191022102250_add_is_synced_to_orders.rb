class AddIsSyncedToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :is_synced, :boolean
  end
end
