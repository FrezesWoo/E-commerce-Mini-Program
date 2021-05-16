class AddQuantityToProductSkus < ActiveRecord::Migration[5.2]
  def change
    add_column :product_skus, :quantity, :integer
  end
end
