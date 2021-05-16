class CreatePageBlockBlockProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :page_block_block_products do |t|
      t.references :page_block_block, foreign_key: true
      t.references :product_sku, foreign_key: true
      t.integer :sorting
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_foreign_key :page_block_block_products, :users, column: :created_by_id, primary_key: :id
    add_foreign_key :page_block_block_products, :users, column: :updated_by_id, primary_key: :id
  end
end
