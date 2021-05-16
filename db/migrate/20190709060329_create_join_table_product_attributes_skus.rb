class CreateJoinTableProductAttributesSkus < ActiveRecord::Migration[5.2]
  def change
    create_join_table :product_product_attributes, :product_skus do |t|
      # t.index [:product_product_attribute_id, :product_sku_id]
      # t.index [:product_sku_id, :product_product_attribute_id]
    end
  end
end
