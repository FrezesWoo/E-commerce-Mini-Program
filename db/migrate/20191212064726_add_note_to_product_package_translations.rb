class AddNoteToProductPackageTranslations < ActiveRecord::Migration[5.2]
  def change
    add_column :product_package_translations, :note, :string
  end
end
