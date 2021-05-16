class AddCreatedByUpdatedByToProductBundles < ActiveRecord::Migration[5.2]
  def change
    add_column :product_bundles, :created_by_id, :integer
    add_column :product_bundles, :updated_by_id, :integer
    add_foreign_key :product_bundles, :users, column: :created_by_id, primary_key: :id
    add_foreign_key :product_bundles, :users, column: :updated_by_id, primary_key: :id
  end
end
