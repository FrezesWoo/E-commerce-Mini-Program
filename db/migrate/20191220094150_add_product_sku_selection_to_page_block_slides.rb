class AddProductSkuSelectionToPageBlockSlides < ActiveRecord::Migration[5.2]
  def change
    add_reference :page_block_slides, :product_sku, foreign_key: true
  end
end
