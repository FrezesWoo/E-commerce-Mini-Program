class CreateProductPackageBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :product_package_blocks do |t|
      t.references :product_package, foreign_key: true
      t.integer :template
      t.attachment :image
      t.attachment :video
      t.string :link
      t.float :x_position
      t.float :y_position
      t.float :link_width
      t.float :link_height
      t.integer :ordering

      t.timestamps
    end
  end
end
