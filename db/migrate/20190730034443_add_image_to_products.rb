class AddImageToProducts < ActiveRecord::Migration[5.2]
  def change
    change_table :products do |t|
      t.attachment :image
    end
  end
end
