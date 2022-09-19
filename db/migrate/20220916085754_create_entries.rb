class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.references :customer, null: false, foreign_key: true, type: :integer
      t.references :room,     null: false, foreign_key: true, type: :integer
      t.timestamps
    end
  end
end
