class CreatePackageSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :package_subscriptions do |t|
      t.references :product_package, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
