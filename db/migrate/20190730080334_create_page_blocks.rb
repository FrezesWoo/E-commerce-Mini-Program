class CreatePageBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :page_blocks do |t|
      t.integer :template
      t.string :name
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_foreign_key :page_blocks, :users, column: :created_by_id, primary_key: :id
    add_foreign_key :page_blocks, :users, column: :updated_by_id, primary_key: :id
  end
end
