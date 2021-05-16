class CreateOrderBundles < ActiveRecord::Migration[5.2]
  def change
    create_table :order_bundles do |t|
      t.references :product_sku, foreign_key: true
      t.references :product_bundle, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
