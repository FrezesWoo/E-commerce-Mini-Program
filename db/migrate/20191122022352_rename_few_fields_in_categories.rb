class RenameFewFieldsInCategories < ActiveRecord::Migration[5.2]
  def change
    rename_table :product_product_categories, :product_categories
    rename_column :product_categories, :picture_file_name, :image_file_name
    rename_column :product_categories, :picture_content_type, :image_content_type
    rename_column :product_categories, :picture_file_size, :image_file_size
    rename_column :product_categories, :picture_updated_at, :image_updated_at
    rename_column :products, :product_product_category_id, :product_category_id
  end
end
