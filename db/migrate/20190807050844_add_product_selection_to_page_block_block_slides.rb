class AddProductSelectionToPageBlockBlockSlides < ActiveRecord::Migration[5.2]
  def change
    add_reference :page_block_block_slides, :product, foreign_key: true
  end
end
