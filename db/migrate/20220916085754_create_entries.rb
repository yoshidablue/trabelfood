class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.bigint :customer_id, null: false, foreign_key: true
      t.bigint :room_id,     null: false, foreign_key: true
      t.timestamps
    end
  end
end
