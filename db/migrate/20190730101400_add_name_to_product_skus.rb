class AddNameToProductSkus < ActiveRecord::Migration[5.2]
  def change
    add_column :product_skus, :name, :string
    add_column :product_sku_translations, :name, :string
  end
end
