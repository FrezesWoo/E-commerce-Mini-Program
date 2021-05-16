class ChangeOrderNumberType < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :order_number, 'integer USING CAST(order_number AS integer)'
  end
end
