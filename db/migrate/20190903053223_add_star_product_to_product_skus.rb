class AddStarProductToProductSkus < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :star_product, :boolean
  end
end
