class AddOrderingToProductBundles < ActiveRecord::Migration[5.2]
  def change
    add_column :product_bundles, :ordering, :integer
  end
end
