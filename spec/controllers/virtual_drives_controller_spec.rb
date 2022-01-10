require 'rails_helper'

RSpec.describe VirtualDrivesController, type: :controller do
  render_views

  describe '#show' do
    context 'when exists' do
      it 'should be successful' do
        get :drive

        expect(response).to be_successful
      end

      it 'should show folder' do
        folder = Folder.create(name: 'test_folder')

        get :drive

        expect(response.body).to include(folder.name)
      end

      it 'should show file' do
        file = Item.create(name: 'test.txt',
                           attachment: Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/test.txt"))

        get :drive

        expect(response.body).to include(file.name)
      end

      it 'should open subfolders' do
        folder = Folder.create(name: 'test_folder')
        sub_folder = Folder.create(name: 'second_test_folder', parent: folder)
        child_of_sub_folder = Folder.create(name: 'child_test_folder', parent: sub_folder)
        sub_folders_file = Item.create(name: 'test.txt',
                                       attachment: Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/test.txt"),
                                      folder: sub_folder)

        get :drive, params: { folder_id: sub_folder.id }

        expect(response).to be_successful
        expect(response.body).to include(child_of_sub_folder.name)
        expect(response.body).to include(sub_folders_file.name)
      end
    end
  end
end
