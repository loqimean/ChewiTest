class City < ApplicationRecord
  has_many :users

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
end
