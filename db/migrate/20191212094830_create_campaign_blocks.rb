class CreateCampaignBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :campaign_blocks do |t|
      t.attachment :image
      t.attachment :video
      t.references :mp_link, foreign_key: true
      t.float :x_position
      t.float :y_position
      t.float :link_width
      t.float :link_height
      t.integer :template
      t.integer :ordering
      t.references :product, foreign_key: true
      t.references :product_package, foreign_key: true
      t.references :campaign, foreign_key: true

      t.timestamps
    end
  end
end
