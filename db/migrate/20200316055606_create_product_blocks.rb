class CreateProductBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :product_blocks do |t|
      t.references :product, foreign_key: true
      t.attachment :image
      t.attachment :video
      t.float :x_position
      t.float :y_position
      t.float :link_width
      t.float :link_height
      t.integer :template
      t.integer :ordering

      t.timestamps
    end
  end
end
