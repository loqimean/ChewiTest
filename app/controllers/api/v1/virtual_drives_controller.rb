class Api::V1::VirtualDrivesController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /virtual_drives
  def create
    path_name = Pathname.new(virtual_drive_params[:relative_path])
    folder_names = path_name.each_filename.to_a

    case virtual_drive_params[:type]
    when 'DIRECTORY'
      Folder.find_or_create_folder_by_names(folder_names)
    when 'FILE'
      file_name = path_name.basename.to_s
      folder_id = Folder.find_or_create_folder_by_names(folder_names[0..-2])

      Item.create(name: file_name, folder_id: folder_id, attachment: virtual_drive_params[:attachment])
    end
  end

  private

    def virtual_drive_params
      params.permit(:type, :relative_path, :attachment)
    end
end
