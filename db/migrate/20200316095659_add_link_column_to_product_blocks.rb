class AddLinkColumnToProductBlocks < ActiveRecord::Migration[5.2]
  def change
    add_column :product_blocks, :link, :string
  end
end
