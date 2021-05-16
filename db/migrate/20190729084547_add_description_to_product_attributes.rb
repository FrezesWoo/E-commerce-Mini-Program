class AddDescriptionToProductAttributes < ActiveRecord::Migration[5.2]
  def change
    add_column :product_product_attributes, :description, :text
    rename_column :product_product_attributes, :value, :composition
    add_column :product_product_attribute_translations, :description, :text
    rename_column :product_product_attribute_translations, :value, :composition
  end
end
