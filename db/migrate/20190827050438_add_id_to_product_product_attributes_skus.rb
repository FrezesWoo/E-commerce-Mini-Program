class AddIdToProductProductAttributesSkus < ActiveRecord::Migration[5.2]
  def change
    add_column :product_product_attributes_skus, :id, :serial, null: false, unique: true, primary_key: true
  end
end
