class AddDefaultValueToOrderStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :orders, :status, 0
  end
end
