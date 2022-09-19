class Group < ApplicationRecord

  has_many :group_customers, dependent: :destroy
  has_many :group_comments,  dependent: :destroy
  has_many :customers, through: :group_customers

  has_one_attached :group_image

  def get_group_image
    (group_image.attached?) ? group_image: 'no_image.jpg'
  end

end