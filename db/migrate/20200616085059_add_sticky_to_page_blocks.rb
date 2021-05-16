class AddStickyToPageBlocks < ActiveRecord::Migration[5.2]
  def change
    add_column :page_blocks, :sticky, :boolean, default: true
  end
end
