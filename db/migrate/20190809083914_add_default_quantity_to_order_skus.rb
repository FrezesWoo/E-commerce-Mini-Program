class AddDefaultQuantityToOrderSkus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :order_skus, :quantity, 1
  end
end
