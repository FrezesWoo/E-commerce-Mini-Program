class AddFewFieldsToPageBlockSlides < ActiveRecord::Migration[5.2]
  def change
    add_column :page_block_slides, :link_type, :integer
    add_column :page_block_slides, :page_id, :integer
    add_column :page_block_slides, :mp_name, :string
  end
end
