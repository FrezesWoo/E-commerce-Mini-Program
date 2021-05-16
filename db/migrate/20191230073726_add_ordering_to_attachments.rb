class AddOrderingToAttachments < ActiveRecord::Migration[5.2]
  def change
    add_column :attachments, :ordering, :integer
  end
end
