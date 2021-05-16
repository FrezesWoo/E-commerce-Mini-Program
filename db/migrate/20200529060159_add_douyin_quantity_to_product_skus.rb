class AddDouyinQuantityToProductSkus < ActiveRecord::Migration[5.2]
  def change
    add_column :product_skus, :douyin_quantity, :integer, default: 0
  end
end