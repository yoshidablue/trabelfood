class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer  :customer_id  , null: false
      t.integer  :prefecture_id, null: false
      t.string   :food_name    , null: false
      t.text     :introduction , null: false
      t.timestamps
    end
  end
end
