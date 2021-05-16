class CreateSeos < ActiveRecord::Migration[5.2]
  def change
    create_table :seos do |t|
      t.string :slug
      t.string :meta_keywords
      t.text :meta_description
      t.string :meta_title
      t.integer :seoable_id
      t.string :seoable_type

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Seo.create_translation_table! :slug => :string, :meta_keywords => :string, :meta_description => :text, :meta_title => :string
      end

      dir.down do
        Seo.drop_translation_table!
      end
    end
  end
end
