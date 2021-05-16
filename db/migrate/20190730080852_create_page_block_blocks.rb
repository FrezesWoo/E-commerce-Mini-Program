class CreatePageBlockBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :page_block_blocks do |t|
      t.string :name
      t.string :title
      t.text :description
      t.attachment :image
      t.integer :template
      t.references :page_block, foreign_key: true
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_foreign_key :page_block_blocks, :users, column: :created_by_id, primary_key: :id
    add_foreign_key :page_block_blocks, :users, column: :updated_by_id, primary_key: :id

    reversible do |dir|
      dir.up do
        PageBlock::Block.create_translation_table! :title => :string, :description => :text
      end

      dir.down do
        PageBlock::Block.drop_translation_table!
      end
    end
  end
end
