class CreateGroupCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_customers do |t|
      t.integer :customer_id, null: false
      t.integer :group_id,    null: false
      t.timestamps
    end
  end
end
