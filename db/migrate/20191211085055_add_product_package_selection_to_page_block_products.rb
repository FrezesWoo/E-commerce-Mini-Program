class AddProductPackageSelectionToPageBlockProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :page_block_products, :product_type, :integer
    add_reference :page_block_products, :product_package, foreign_key: true
  end
end
