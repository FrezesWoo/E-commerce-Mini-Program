class CreateSmsVerifications < ActiveRecord::Migration[5.2]
  def change
    create_table :sms_verifications do |t|
      t.string :phone
      t.integer :code

      t.timestamps
    end
  end
end
