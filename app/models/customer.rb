class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  belongs_to :prefecture, optional: true

  has_many :posts,           dependent: :destroy
  has_many :favorites,       dependent: :destroy
  has_many :food_comments,   dependent: :destroy
  has_many :entries,         dependent: :destroy
  has_many :messages,        dependent: :destroy
  has_many :group_customers, dependent: :destroy
  has_many :group_comments,  dependent: :destroy
  has_many :groups, through: :group_customers
  # フォローした、されたの関係
  has_many :relationships,            class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面で使用
  has_many :followings,    through: :relationships,            source: :followed
  has_many :followers,     through: :reverse_of_relationships, source: :follower

  def get_profile_image
    (profile_image.attached?) ? profile_image: 'no_image.jpg'
  end

  def follow(customer_id)
    customer = Customer.find(customer_id)
    relationships.find_or_create_by(followed_id: customer.id)
  end

  def unfollow(customer_id)
    customer = Customer.find(customer_id)
    relationship = relationships.find_by(followed_id: customer.id)
    relationship.destroy if relationship
  end

  def following?(customer)
    followings.include?(customer)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "guestuser"
    end
  end

end