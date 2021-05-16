class AddGiftUserToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :gift_to_user, :string
    add_column :orders, :gift_from_user, :string
  end
end
