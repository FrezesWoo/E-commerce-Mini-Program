class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    reversible do |dir|
      dir.up do
        Country.create_translation_table! :name => :string
      end

      dir.down do
        Country.drop_translation_table!
      end
    end
  end
end
