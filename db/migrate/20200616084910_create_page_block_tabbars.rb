class CreatePageBlockTabbars < ActiveRecord::Migration[5.2]
  def change
    create_table :page_block_tabbars do |t|
      t.references :page_block, foreign_key: true
      t.integer :target
      t.attachment :anchor_hover
      t.attachment :anchor_active
      t.integer :ordering
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_foreign_key :page_block_tabbars, :users, column: :created_by_id, primary_key: :id
    add_foreign_key :page_block_tabbars, :users, column: :updated_by_id, primary_key: :id
  end
end