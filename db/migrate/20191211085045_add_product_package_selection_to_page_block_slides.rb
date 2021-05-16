class AddProductPackageSelectionToPageBlockSlides < ActiveRecord::Migration[5.2]
  def change
    add_reference :page_block_slides, :product_package, foreign_key: true
  end
end
