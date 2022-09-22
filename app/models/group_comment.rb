class GroupComment < ApplicationRecord

  belongs_to :customer
  belongs_to :group

  validates :comment, presence: true, length:{maximum: 200}

end