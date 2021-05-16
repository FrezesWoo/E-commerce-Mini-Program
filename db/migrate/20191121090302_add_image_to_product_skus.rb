class AddImageToProductSkus < ActiveRecord::Migration[5.2]
  def change
    add_column :product_skus, :image_file_name, :string
    add_column :product_skus, :image_content_type, :string
    add_column :product_skus, :image_file_size, :bigint
    add_column :product_skus, :image_updated_at, :datetime
  end
end
