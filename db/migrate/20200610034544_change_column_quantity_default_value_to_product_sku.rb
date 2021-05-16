class ChangeColumnQuantityDefaultValueToProductSku < ActiveRecord::Migration[5.2]
  def change
    change_column_default :product_skus, :quantity, 0
  end
end
