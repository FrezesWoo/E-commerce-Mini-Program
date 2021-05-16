class RenameTranslationTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :product_product_category_translations, :product_category_translations
    rename_column :product_category_translations, :product_product_category_id, :product_category_id
  end
end
