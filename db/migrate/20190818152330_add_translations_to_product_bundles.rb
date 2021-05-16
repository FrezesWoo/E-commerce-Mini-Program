class AddTranslationsToProductBundles < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        Product::Bundle.create_translation_table! :name => :string
      end

      dir.down do
        Product::Bundle.drop_translation_table!
      end
    end
  end
end
