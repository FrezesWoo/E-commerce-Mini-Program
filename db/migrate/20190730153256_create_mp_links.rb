class CreateMpLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :mp_links do |t|
      t.string :name
      t.string :param
      t.string :path

      t.timestamps
    end
  end
end
