class CreateOrdersSkus < ActiveRecord::Migration[5.2]
  def change
    create_table :order_skus do |t|
      t.references :product_sku, foreign_key: true
      t.integer :quantity
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
