class RenameSomeTables < ActiveRecord::Migration[5.2]
  def change
    rename_table :page_blocks, :pages
    rename_table :page_block_blocks, :page_blocks
    rename_table :page_block_block_translations, :page_block_translations
    rename_table :page_block_block_products, :page_block_products
    rename_table :page_block_block_slides, :page_block_slides
    rename_table :page_block_block_slide_translations, :page_block_slide_translations

    rename_column :page_blocks, :page_block_id, :page_id
    rename_column :page_block_translations, :page_block_block_id, :page_block_id
    rename_column :page_block_products, :page_block_block_id, :page_block_id
    rename_column :page_block_slides, :page_block_block_id, :page_block_id
    rename_column :page_block_slide_translations, :page_block_block_slide_id, :page_block_slide_id
  end
end
