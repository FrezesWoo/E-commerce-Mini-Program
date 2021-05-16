class CreateAddSkuToProductPackages < ActiveRecord::Migration[5.2]
  def change
    change_table :product_packages do |t|
      t.string :sku
      t.integer :quantity
      t.float :price
    end
  end
end
