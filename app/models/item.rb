class Item < ApplicationRecord
  mount_uploader :attachment, FileUploader

  belongs_to :folder

  validates :name, :attachment, presence: true
  validates_uniqueness_of :name, scope: :folder_id
end
