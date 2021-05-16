class AddStatusToProductBundles < ActiveRecord::Migration[5.2]
  def change
    add_column :product_bundles, :status, :boolean
  end
end
