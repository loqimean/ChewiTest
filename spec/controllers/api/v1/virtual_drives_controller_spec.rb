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

    it 'should be successful' do
      post :create, params: {
        type: 'DIRECTORY',
        relative_path: 'a/b/c'
      }

      expect(response).to be_successful
    end
  end
end
