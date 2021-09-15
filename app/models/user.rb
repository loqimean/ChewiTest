class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  belongs_to :city

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :seniority, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email, presence: true, length: { minimum: 5, maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  update_index('users') { self }

  accepts_nested_attributes_for :city
end
