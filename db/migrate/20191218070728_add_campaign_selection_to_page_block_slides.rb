class AddCampaignSelectionToPageBlockSlides < ActiveRecord::Migration[5.2]
  def change
    add_reference :page_block_slides, :campaign, foreign_key: true
  end
end
