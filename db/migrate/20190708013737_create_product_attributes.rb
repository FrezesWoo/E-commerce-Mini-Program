class CreateProductAttributes < ActiveRecord::Migration[5.2]
  def change
    create_table :product_product_attributes do |t|
      t.string :name
      t.string :value
      t.attachment :picture
      t.references :product_product_attribute_category, foreign_key: true, index: { name: :product_attribute_and_category_index }
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_foreign_key :product_product_attributes, :users, column: :created_by_id, primary_key: :id
    add_foreign_key :product_product_attributes, :users, column: :updated_by_id, primary_key: :id

    reversible do |dir|
      dir.up do
        Product::ProductAttribute.create_translation_table! :name => :string, :value => :string
      end

      dir.down do
        Product::ProductAttribute.drop_translation_table!
      end
    end
  end
end
