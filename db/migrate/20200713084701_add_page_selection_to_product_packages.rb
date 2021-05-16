class AddPageSelectionToProductPackages < ActiveRecord::Migration[5.2]
  def change
    add_reference :product_packages, :page, foreign_key: true
  end
end
