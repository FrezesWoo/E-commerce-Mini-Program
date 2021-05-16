class AddFewFieldsToPageBlocks < ActiveRecord::Migration[5.2]
  def change
    add_column :page_blocks, :link_width, :float
    add_column :page_blocks, :link_height, :float
  end
end
