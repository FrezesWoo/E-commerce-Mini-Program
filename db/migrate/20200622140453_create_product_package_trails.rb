class CreateProductPackageTrails < ActiveRecord::Migration[5.2]
  def change
    create_table :product_package_trails do |t|
      t.references :product_package, foreign_key: true
      t.datetime :trial_start_date
      t.datetime :trial_end_date

      t.timestamps
    end
  end
end
