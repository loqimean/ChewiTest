class Folder < ApplicationRecord
  belongs_to :parent, class_name: 'Folder', foreign_key: 'folder_id', optional: true
  has_many :children, class_name: 'Folder', dependent: :destroy
  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :folder_id, conditions: ->(folder) {
    Item.where(name: folder.name, folder_id: folder.folder_id)
  }

  def self.find_or_create_by_path(path)
    path = path.split('/') if path.instance_of?(String)
    previous_folder_id = nil

    path.each do |folder_name|
      folder = find_or_create_by(name: folder_name, folder_id: previous_folder_id)
      previous_folder_id = folder.id
    end

    previous_folder_id
  end

  def self.find_by_path(path)
    path = path.split('/') if path.instance_of?(String)
    object_name = path[-1]

    if path.length > 1
      folder_names = path[0..-2]
      previous_folder = OpenStruct.new(id: nil)

      folder_names.each do |folder_name|
        folder = find_by(name: folder_name, folder_id: previous_folder.id)
        previous_folder = folder
      end

      folder = previous_folder.children.find_by_name(object_name)
      files = previous_folder.items
    else
      folder = find_by_name(object_name)
      files = Item
    end

    return folder unless folder.nil?

    files.find_by_name(object_name)
  end

  def relative_path
    array_of_names = [name]

    if folder_id.present?
      previous_folder = self.class.find(folder_id)

      loop do
        array_of_names.push(previous_folder.name)

        break if previous_folder.folder_id.nil?

        previous_folder = self.class.find(previous_folder.folder_id)
      end
    end

    array_of_names.reverse.join('/')
  end
end
