class ChangeNameOrderingFromPageBlockBlocks < ActiveRecord::Migration[5.2]
  def change
    rename_column :page_block_block_products, :sorting, :ordering
  end
end
