class Api::V1::VirtualDrivesController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /virtual_drives
  def create
    case virtual_drive_params[:type]
    when 'DIRECTORY'
      if Folder.find_or_create_by_path(virtual_drive_params[:relative_path])
        render json: { message: 'Folder has been successfuly created' }, status: :created
      else
        render json: { message: 'Something went wrong' }, status: :bad_request
      end
    when 'FILE'
      path_name = Pathname.new(virtual_drive_params[:relative_path])
      *folder_names, file_name = path_name.each_filename.to_a
      folder = Folder.find_or_create_by_path(folder_names.join('/'))

      item = Item.new(name: file_name, folder: folder, attachment: virtual_drive_params[:attachment])

      if item.save
        render json: { message: 'File has been successfuly created' }, status: :created
      else
        render json: { message: 'Something went wrong' }, status: :bad_request
      end
    end
  end

  # DELETE /virtual_drives
  def destroy
    folder = FileManager.find_by_path(virtual_drive_params[:relative_path])

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
