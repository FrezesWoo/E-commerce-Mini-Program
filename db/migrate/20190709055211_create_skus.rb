class CreateSkus < ActiveRecord::Migration[5.2]
  def change
    create_table :product_skus do |t|
      t.float :price
      t.references :product, foreign_key: true
      t.float :shipping_price
      t.integer :currency
      t.text :description
      t.text :composition
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_foreign_key :product_skus, :users, column: :created_by_id, primary_key: :id
    add_foreign_key :product_skus, :users, column: :updated_by_id, primary_key: :id

    reversible do |dir|
      dir.up do
        Product::Sku.create_translation_table! :currency => :integer, :description => :text, :composition => :text
      end

      dir.down do
        Product::Sku.drop_translation_table!
      end
    end
  end
end
