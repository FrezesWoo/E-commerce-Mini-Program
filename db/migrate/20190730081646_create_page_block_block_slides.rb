class CreatePageBlockBlockSlides < ActiveRecord::Migration[5.2]
  def change
    create_table :page_block_block_slides do |t|
      t.references :page_block_block, foreign_key: true
      t.string :title
      t.text :description
      t.attachment :image
      t.string :alt
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_foreign_key :page_block_block_slides, :users, column: :created_by_id, primary_key: :id
    add_foreign_key :page_block_block_slides, :users, column: :updated_by_id, primary_key: :id

    reversible do |dir|
      dir.up do
        PageBlock::BlockSlide.create_translation_table! :title => :string, :description => :text, :alt => :string
      end

      dir.down do
        PageBlock::BlockSlide.drop_translation_table!
      end
    end
  end
end
