class FileManager
  def self.find_by_path(path)
    names = path.instance_of?(String) ? path.split('/') : path
    object_name = names.pop
    parent_folder = nil

    names.each do |name|
      parent_folder = Folder.find_by(name: name, parent: parent_folder&.id)
    end

    folder = Folder.find_by(name: object_name, parent: parent_folder)

    return folder if folder.present?

    Item.find_by(name: object_name, folder: parent_folder)
  end
end
