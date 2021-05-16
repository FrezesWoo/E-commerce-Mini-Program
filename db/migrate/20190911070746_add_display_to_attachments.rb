class AddDisplayToAttachments < ActiveRecord::Migration[5.2]
  def change
    add_column :attachments, :display, :boolean, default: true
  end
end
