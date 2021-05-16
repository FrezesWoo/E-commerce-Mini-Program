class AddQuantityToProductBundles < ActiveRecord::Migration[5.2]
  def change
    add_column :product_bundles, :quantity, :integer
  end
end
