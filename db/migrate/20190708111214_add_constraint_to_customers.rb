class AddConstraintToCustomers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :customers, :open_id, false
    add_index :customers, :open_id, :unique => true
    reversible do |dir|
      dir.up do
        # add a CHECK constraint
        execute <<-SQL
          ALTER TABLE customers
            ADD CONSTRAINT unique_phone UNIQUE(phone);
          ALTER TABLE customers
            ADD CONSTRAINT unique_union_id UNIQUE(union_id);
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE customers
            DROP CONSTRAINT unique_phone;
          ALTER TABLE customers
            DROP CONSTRAINT unique_union_id;
        SQL
      end
    end
  end
end
