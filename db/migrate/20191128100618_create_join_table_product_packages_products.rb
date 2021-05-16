class CreateJoinTableProductPackagesProducts < ActiveRecord::Migration[5.2]
  def change
    create_join_table :product_packages, :products do |t|
      # t.index [:product_package_id, :product_id]
      # t.index [:product_id, :product_package_id]
    end
  end
end
