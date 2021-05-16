class CreateMpImages < ActiveRecord::Migration[5.2]
  def change
    create_table :mp_images do |t|
      t.string :name
      t.integer :updated_by_id
      t.string :image_file_name
      t.string :image_content_type
      t.bigint :image_file_size
      t.datetime :image_updated_at

      t.timestamps
    end
  end
end
