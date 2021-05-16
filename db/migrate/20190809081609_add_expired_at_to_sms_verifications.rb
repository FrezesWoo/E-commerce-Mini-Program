class AddExpiredAtToSmsVerifications < ActiveRecord::Migration[5.2]
  def change
    add_column :sms_verifications, :expired_at, :datetime
  end
end
