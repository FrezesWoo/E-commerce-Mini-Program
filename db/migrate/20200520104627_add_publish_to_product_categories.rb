class AddPublishToProductCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :product_categories, :publish, :boolean, default: true
  end
end
