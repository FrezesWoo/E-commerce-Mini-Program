class AddOrderingToProductSkus < ActiveRecord::Migration[5.2]
  def change
    add_column :product_skus, :ordering, :integer
  end
end
