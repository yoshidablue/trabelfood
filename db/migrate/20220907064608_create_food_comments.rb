class CreateFoodComments < ActiveRecord::Migration[6.1]
  def change
    create_table :food_comments do |t|
      t.integer :post_id    , null: false
      t.integer :customer_id, null: false
      t.text    :comment    , null: false
      t.timestamps
    end
  end
end
