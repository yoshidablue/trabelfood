class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.bigint :customer, null: false, foreign_key: true
      t.bigint :room,     null: false, foreign_key: true
      t.timestamps
    end
  end
end
