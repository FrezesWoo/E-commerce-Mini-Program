class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.attachment :file
      t.integer :weight
      t.string :alt
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_foreign_key :attachments, :users, column: :created_by_id, primary_key: :id
    add_foreign_key :attachments, :users, column: :updated_by_id, primary_key: :id

  end
end
