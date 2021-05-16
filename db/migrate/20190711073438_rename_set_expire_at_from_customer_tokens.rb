class RenameSetExpireAtFromCustomerTokens < ActiveRecord::Migration[5.2]
  def change
    rename_column :customer_tokens, :set_expire_at, :expire_at
  end
end
