class Folder < ApplicationRecord
  belongs_to :parent, class_name: 'Folder', foreign_key: 'folder_id', optional: true
  has_many :children, class_name: 'Folder', dependent: :destroy
  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :folder_id, conditions: ->(folder) {
    Item.where(name: folder.name, folder_id: folder.folder_id)
  }

  def self.find_or_create_by_path(path)
    names = path.instance_of?(String) ? path.split('/') : path
    parent_folder = nil

    names.each do |name|
      parent_folder = find_or_create_by(name: name, parent: parent_folder)
    end

    parent_folder
  end

  def relative_path
    array_of_names = [name]

    if folder_id.present?
      parent_folder = self.class.find(folder_id)

      loop do
        array_of_names.push(parent_folder.name)

        break if parent_folder.folder_id.nil?

        parent_folder = self.class.find(parent_folder.folder_id)
      end
    end

    array_of_names.reverse.join('/')
  end
end
