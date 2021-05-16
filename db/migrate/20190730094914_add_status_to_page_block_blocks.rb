class AddStatusToPageBlockBlocks < ActiveRecord::Migration[5.2]
  def change
    add_column :page_block_blocks, :status, :integer
  end
end
