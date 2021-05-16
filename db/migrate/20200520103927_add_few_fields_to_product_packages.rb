class AddFewFieldsToProductPackages < ActiveRecord::Migration[5.2]
  def change
    add_column :product_packages, :publish, :boolean, default: true
    add_column :product_packages, :hidden_product, :boolean, default: false
    add_reference :product_packages, :product_categories, foreign_key: true
    rename_column :product_packages, :product_categories_id, :product_category_id
    add_column :product_packages, :composition, :string
    add_column :product_packages, :shipping_price, :float
  end
end
