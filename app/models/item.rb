class Item < ApplicationRecord
  mount_uploader :attachment, FileUploader

  belongs_to :folder, optional: true

  validates :name, :attachment, presence: true
  validates_uniqueness_of :name, scope: :folder_id

  def relative_path
    array_of_names = [name]

    if folder_id.present?
      previous_folder = Folder.find(folder_id)

      loop do
        array_of_names.push(previous_folder.name)

        break if previous_folder.folder_id.nil?

        previous_folder = Folder.find(previous_folder.folder_id)
      end
    end

    array_of_names.reverse.join('/')
  end
end
