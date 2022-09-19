class Post < ApplicationRecord

  has_many :favorites,     dependent: :destroy
  has_many :food_comments, dependent: :destroy
  has_many :post_tags,     dependent: :destroy
  has_many :tags, through: :post_tags

  has_one_attached :image

  belongs_to :customer
  belongs_to :prefecture

  validates :image,         presence: true
  validates :prefecture_id, presence: true
  validates :food_name,     presence: true
  validates :introduction,  presence: true

  scope :latest,     -> {order(created_at: :desc)}
  scope :old,        -> {order(created_at: :asc)}
  scope :star_count, -> {find(FoodComment.group(:post_id).order('avg(star) desc').pluck(:post_id))}

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags
    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end
    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end

  def self.search(search)
    if search != ""
      Post.where('food_name LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end

  def self.search_prefecture(search)
    if search != ""
      Post.where(prefecture_id: search)
    end
  end

end