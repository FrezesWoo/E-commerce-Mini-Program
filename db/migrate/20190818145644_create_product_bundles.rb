class CreateProductBundles < ActiveRecord::Migration[5.2]
  def change
    create_table :product_bundles do |t|
      t.string :name
      t.integer :condition
      t.float :price
      t.float :price_condition
      t.references :product_sku, foreign_key: true

      t.timestamps
    end
  end
end
