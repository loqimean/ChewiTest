require 'rails_helper'

RSpec.describe Api::V1::VirtualDrivesController, type: :controller do
  describe '#create (POST)' do
    it 'should create folder' do
      post :create, params: {
        type: 'DIRECTORY',
        relative_path: 'a/b/c'
      }

      c_folder = Folder.find_by_name('c')
      a_folder = Folder.find_by_name('a')

      expect(c_folder).not_to be_nil
      expect(a_folder.parent).to be_nil

      expect(c_folder.parent).to eq(Folder.find_by_name('b'))
      expect(a_folder.children).to eq(Folder.where(name: 'b'))
    end

    it 'should create file' do
      post :create, params: {
        type: 'FILE',
        relative_path: 'd/e/test.txt',
        attachment: Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/test.txt")
      }

      file = Item.find_by_name('test.txt')

      expect(file).not_to be_nil
      expect(file.folder).to eq(Folder.find_by_name('e'))
    end

    it 'should be successful for DIRECTORY' do
      post :create, params: {
        type: 'DIRECTORY',
        relative_path: 'a/b/c'
      }

      expect(response).to be_successful
    end

    it 'should be successful for FILE' do
      post :create, params: {
        type: 'FILE',
        relative_path: 'a/b/c/file.txt',
        attachment: Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/test.txt")
      }

      expect(response).to be_successful
    end
  end

  describe '#destroy (DELETE)' do
    let(:path_to_folder) { 'path/to/folder' }
    let(:path_to_folder_with_child) { 'path/to/folder/child' }

    context 'when type DIRECTORY' do
      it 'should be successful for folder' do
        folder_id = Folder.find_or_create_folder_by_names(path_to_folder)

        delete :destroy, params: { relative_path: 'path/to/folder' }

        expect(Folder.find_by(id: folder_id)).to be_nil
      end

      it 'should remove children' do
        child_id = Folder.find_or_create_folder_by_names(path_to_folder_with_child)
        parent_id = Folder.find_or_create_folder_by_names(path_to_folder)

        delete :destroy, params: { relative_path: 'path/to/folder' }

        expect(Folder.find_by(id: parent_id)).to be_nil
        expect(Folder.find_by(id: child_id)).to be_nil
      end
    end
  end
end
