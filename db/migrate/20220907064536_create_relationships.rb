class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.bigint  :follower_id
      t.bigint  :followed_id
      t.timestamps
    end
  end
end
