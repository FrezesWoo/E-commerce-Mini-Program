class AddOptionsToPageBlockBlocks < ActiveRecord::Migration[5.2]
  def change
    add_column :page_block_blocks, :has_dots, :boolean
    add_column :page_block_blocks, :has_arrows, :boolean
    add_column :page_block_blocks, :height, :string
  end
end
