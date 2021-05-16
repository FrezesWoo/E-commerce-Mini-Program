class AddCompositionToProductPackageTranslations < ActiveRecord::Migration[5.2]
  def change
    add_column :product_package_translations, :composition, :string
  end
end
