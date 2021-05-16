class CreateProductAttributeCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :product_product_attribute_categories do |t|
      t.string :name
      t.attachment :picture
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_foreign_key :product_product_attribute_categories, :users, column: :created_by_id, primary_key: :id
    add_foreign_key :product_product_attribute_categories, :users, column: :updated_by_id, primary_key: :id

    reversible do |dir|
      dir.up do
        Product::ProductAttributeCategory.create_translation_table! :name => :string
      end

      dir.down do
        Product::ProductAttributeCategory.drop_translation_table!
      end
    end

  end
end
