class CreateOrderPackages < ActiveRecord::Migration[5.2]
  def change
    create_table :order_packages do |t|
      t.references :order, foreign_key: true
      t.references :product_package, foreign_key: true

      t.timestamps
    end
  end
end
