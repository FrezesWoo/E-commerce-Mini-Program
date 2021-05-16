class AddLinkToPageBlocks < ActiveRecord::Migration[5.2]
  def change
    add_column :page_block_blocks, :link, :string
  end
end
