class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :customer, null: false, foreign_key: true, type: :bigint
      t.references :room,     null: false, foreign_key: true, type: :bigint
      t.text       :content
      t.timestamps
    end
  end
end
