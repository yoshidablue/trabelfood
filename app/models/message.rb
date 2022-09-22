class Message < ApplicationRecord

  belongs_to :customer
  belongs_to :room

  validates :content, presence: true, length:{maximum: 200}

end