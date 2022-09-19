class CreateGroupCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_customers do |t|
      t.bigint :customer_id, null: false
      t.bigint :group_id,    null: false
      t.timestamps
    end
  end
end
