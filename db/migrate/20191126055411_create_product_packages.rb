class CreateProductPackages < ActiveRecord::Migration[5.2]
  def change
    create_table :product_packages do |t|
      t.string :name
      t.string :description
      t.string :note
      t.boolean :star_product
      t.integer :updated_by_id
      t.string :image_file_name
      t.string :image_content_type
      t.bigint :image_file_size
      t.datetime :image_updated_at
      t.integer :ordering

      t.timestamps
    end

    add_foreign_key :product_packages, :users, column: :updated_by_id, primary_key: :id

    reversible do |dir|
      dir.up do
        Product::Package.create_translation_table! :name => :string, :description => :text
      end

      dir.down do
        Product::Package.drop_translation_table!
      end
    end
  end
end
