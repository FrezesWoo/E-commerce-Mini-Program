class CreateProductSkuLimits < ActiveRecord::Migration[5.2]
  def change
    create_table :product_sku_limits do |t|
      t.references :product_sku, foreign_key: true
      t.datetime :limit_start_date
      t.datetime :limit_end_date
      t.integer :quantity
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_foreign_key :product_sku_limits, :users, column: :created_by_id, primary_key: :id
    add_foreign_key :product_sku_limits, :users, column: :updated_by_id, primary_key: :id
  end
end
