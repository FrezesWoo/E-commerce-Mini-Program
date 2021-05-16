class AddSortingToProductProductAttributesSkus < ActiveRecord::Migration[5.2]
  def change
    add_column :product_product_attributes_skus, :sorting, :integer
  end
end
