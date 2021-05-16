class AddLinkToPageBlockBlockSlides < ActiveRecord::Migration[5.2]
  def change
    add_column :page_block_block_slides, :link, :string
  end
end
