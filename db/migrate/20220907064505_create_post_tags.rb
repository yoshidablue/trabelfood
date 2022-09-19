class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.bigint  :post_id, foreign_key: true
      t.bigint  :tag_id,  foreign_key: true
      t.timestamps
    end
    # 同じタグを２回保存するのはできないようになる
    add_index :post_tags, [:post_id, :tag_id], unique: true
  end
end
