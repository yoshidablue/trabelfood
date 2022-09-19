class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.bigint :customer, null: false, foreign_key: true
      t.bigint :room,     null: false, foreign_key: true
      t.text       :content
      t.timestamps
    end
  end
end
