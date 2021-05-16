class AddLinkColumnToCampaignBlocks < ActiveRecord::Migration[5.2]
  def change
    add_column :campaign_blocks, :link, :string
  end
end
