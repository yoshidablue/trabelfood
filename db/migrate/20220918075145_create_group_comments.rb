class CreateGroupComments < ActiveRecord::Migration[6.1]
  def change
    create_table :group_comments do |t|
      t.bigint :group_id,    null: false
      t.bigint :customer_id, null: false
      t.text    :comment,     null: false
      t.timestamps
    end
  end
end
