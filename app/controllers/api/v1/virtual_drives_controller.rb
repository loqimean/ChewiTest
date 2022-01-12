class Api::V1::VirtualDrivesController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /virtual_drives
  def create
    path_name = Pathname.new(virtual_drive_params[:relative_path])
    folder_names = path_name.each_filename.to_a

    case virtual_drive_params[:type]
    when 'DIRECTORY'
      if Folder.find_or_create_by_path(folder_names)
        render json: { message: 'Folder has been successfuly created' }, status: :created
      else
        render json: { message: 'Something went wrong' }, status: :bad_request
      end
    when 'FILE'
      file_name = path_name.basename.to_s
      folder_id = Folder.find_or_create_by_path(folder_names[0..-2])

      item = Item.new(name: file_name, folder_id: folder_id, attachment: virtual_drive_params[:attachment])

      if item.save
        render json: { message: 'File has been successfuly created' }, status: :created
      else
        render json: { message: 'Something went wrong' }, status: :bad_request
      end
    end
  end

  # DELETE /virtual_drives
  def destroy
    folder = Folder.find_by_path(virtual_drive_params[:relative_path])

    if folder
      folder.destroy

      render json: { message: 'Successfully destroyed' }, status: :ok
    else
      render json: { error: 'Could not find record' }, status: :not_found
    end
  end

  private

    def virtual_drive_params
      params.permit(:type, :relative_path, :attachment)
    end
end
