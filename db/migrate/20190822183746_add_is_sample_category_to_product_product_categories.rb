class AddIsSampleCategoryToProductProductCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :product_product_categories, :is_sample, :boolean, default: false
  end
end
