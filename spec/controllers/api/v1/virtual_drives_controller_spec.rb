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
    let(:path_to_file) { 'path/to/folder/test.txt' }
    let(:file_name) { 'test.txt' }
    let(:path_to_folder_with_child) { 'path/to/folder/child' }
    let!(:folder_id) { Folder.find_or_create_by_path(path_to_folder) }

    context 'when type   DIRECTORY' do
      it 'should be successful for folder' do
        delete :destroy, params: { relative_path: path_to_folder }

        expect(Folder.find_by(id: folder_id)).to be_nil
      end

      it 'should remove children' do
        child_id = Folder.find_or_create_by_path(path_to_folder_with_child)

        delete :destroy, params: { relative_path: path_to_folder }

        expect(Folder.find_by(id: folder_id)).to be_nil
        expect(Folder.find_by(id: child_id)).to be_nil
      end
    end

    context 'when type FILE' do
      it 'should be successful for folder' do
        file = Item.create(name: 'test.txt',
                           folder_id: folder_id,
                           attachment: Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/test.txt"))

        delete :destroy, params: { relative_path: path_to_file }

        expect(Item.find_by(id: file.id)).to be_nil
      end
    end
  end
end
