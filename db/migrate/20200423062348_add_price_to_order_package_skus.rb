class AddPriceToOrderPackageSkus < ActiveRecord::Migration[5.2]
  def change
    add_column :order_package_skus, :price, :float, default: 0.0
  end
end