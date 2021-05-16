class AddQuantityToOrderPackages < ActiveRecord::Migration[5.2]
  def change
    add_column :order_packages, :quantity, :integer, default: 1
  end
end
