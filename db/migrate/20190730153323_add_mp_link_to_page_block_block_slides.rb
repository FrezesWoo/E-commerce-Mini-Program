class AddMpLinkToPageBlockBlockSlides < ActiveRecord::Migration[5.2]
  def change
    add_reference :page_block_block_slides, :mp_link, foreign_key: true
  end
end
