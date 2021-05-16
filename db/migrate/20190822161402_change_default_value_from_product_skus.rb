class ChangeDefaultValueFromProductSkus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :product_skus, :quantity, 1
    change_column_default :product_skus, :price, 0
  end
end
