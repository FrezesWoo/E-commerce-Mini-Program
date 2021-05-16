class AddIdProductPackagesProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :product_packages_products, :id, :serial, null: false, unique: true, primary_key: true
  end
end
