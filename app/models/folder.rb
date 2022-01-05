class Folder < ApplicationRecord
  belongs_to :parent, class_name: 'Folder', foreign_key: 'folder_id', optional: true
  has_many :children, class_name: 'Folder', dependent: :destroy
  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :folder_id

  def self.find_or_create_folder_by_names(folder_names)
    previous_folder_id = nil

    folder_names.each do |folder_name|
      folder = find_or_create_by(name: folder_name, folder_id: previous_folder_id)
      previous_folder_id = folder.id
    end

    previous_folder_id
  end
end
