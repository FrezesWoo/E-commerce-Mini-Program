class AddQuantityToOrderPackageSkus < ActiveRecord::Migration[5.2]
  def change
    add_column :order_package_skus, :quantity, :integer, default: 1
  end
end
