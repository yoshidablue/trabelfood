class CreateFoodComments < ActiveRecord::Migration[6.1]
  def change
    create_table :food_comments do |t|
      t.bigint :post_id    , null: false
      t.bigint :customer_id, null: false
      t.text    :comment    , null: false
      t.string  :star
      t.timestamps
    end
  end
end
