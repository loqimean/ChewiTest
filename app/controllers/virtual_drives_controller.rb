class VirtualDrivesController < ApplicationController
  def drive
    @folders = Folder.where(folder_id: params[:folder_id])
    @files = Item.where(folder_id: params[:folder_id])
    @folder = folder_resource
  end

  private

    def folder_resource
      Folder.find(params[:folder_id]) if params[:folder_id].present?
    end
end
