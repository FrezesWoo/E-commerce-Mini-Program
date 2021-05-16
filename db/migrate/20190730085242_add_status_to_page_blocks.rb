class AddStatusToPageBlocks < ActiveRecord::Migration[5.2]
  def change
    add_column :page_blocks, :status, :integer
    add_column :page_block_block_slides, :ordering, :integer
  end
end
