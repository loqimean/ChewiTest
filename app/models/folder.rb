class Folder < ApplicationRecord
  belongs_to :parent, class_name: 'Folder', optional: true
  has_many :children, class_name: 'Folder', dependent: :destroy
  has_many :items, dependent: :destroy

  validates_uniqueness_of :name, scope: :folder_id
  validates_presence_of :name
end
