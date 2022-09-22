class FoodComment < ApplicationRecord

  belongs_to :customer
  belongs_to :post

  validates :comment, presence: true, length:{maximum:200}

end