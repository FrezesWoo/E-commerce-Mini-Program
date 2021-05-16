class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :description
      t.string :name
      t.string :note
      t.string :composition
      t.references :product_product_category, foreign_key: true
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_foreign_key :products, :users, column: :created_by_id, primary_key: :id
    add_foreign_key :products, :users, column: :updated_by_id, primary_key: :id

    reversible do |dir|
      dir.up do
        Product.create_translation_table! :name => :string, :note => :string, :composition => :string, :description => :text
      end

      dir.down do
        Product.drop_translation_table!
      end
    end
  end
end
