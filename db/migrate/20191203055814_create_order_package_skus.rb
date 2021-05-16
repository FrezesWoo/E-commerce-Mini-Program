class CreateOrderPackageSkus < ActiveRecord::Migration[5.2]
  def change
    create_table :order_package_skus do |t|
      t.references :order_package, foreign_key: true
      t.references :product_sku, foreign_key: true

      t.timestamps
    end
  end
end
