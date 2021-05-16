class AddOrderingToProductCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :product_product_categories, :ordering, :integer
    add_column :products, :ordering, :integer
  end
end
