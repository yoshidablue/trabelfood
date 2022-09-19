class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :customer, null: false, foreign_key: true, type: :integer
      t.references :room,     null: false, foreign_key: true, type: :integer
      t.text       :content
      t.timestamps
    end
  end
end
