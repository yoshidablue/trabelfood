class Prefecture < ApplicationRecord

  has_many :customers
  has_many :posts,    dependent: :destroy

end