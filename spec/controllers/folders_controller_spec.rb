require 'rails_helper'

RSpec.describe FoldersController, type: :controller do
  context 'POST #create' do
    context 'when folder is root' do
      let(:find_folder) { Folder.find_by_name('other') }
      let(:folder_params_in_root) { { name: 'other' } }

      it 'should be successful' do
        expect do
          post :create, params: { folder: folder_params_in_root }
        end.to change(Folder, :count).by(1)
      end

      it 'should create a new folder' do
        post :create, params: { folder: folder_params_in_root }

        expect(find_folder).not_to be_nil
        expect(find_folder.name).to eq(folder_params_in_root[:name])
        expect(find_folder.folder_id).to be_nil
      end
    end

    context 'when creates in' do
      let!(:first_exists_folder) { Folder.create(name: 'other') }

      context 'one exists folder' do
        # With the element in the end
        # Do we need it in relative_path?
        let(:folder_params) { { name: 'other', relative_path: 'other/other' } }
        let(:find_folder) { Folder.find_by(name: 'other', Folder_id: first_exists_folder.id) }

        it 'should be successful' do
          expect do
            post :create, params: { folder: folder_params }
          end.to change(Folder, :count).by(1)
        end

        it 'should create a new folder' do
          post :create, params: { folder: folder_params }

          expect(find_folder).not_to be_nil
          expect(find_folder.name).to eq(folder_params[:name])
          expect(find_folder.folder_id).to eq(first_exists_folder.id)
        end
      end

      context 'two exists folder' do
        let!(:second_exists_folder) { Folder.create(name: 'other', folder_id: first_exists_folder.id) }
        let(:folder_params) { { name: 'other', relative_path: 'other/other/other' } }
        let(:find_folder) { Folder.find_by(name: 'other', Folder_id: second_exists_folder.id) }

        it 'should be successful' do
          expect do
            post :create, params: { folder: folder_params }
          end.to change(Folder, :count).by(1)
        end

        it 'should create a new folder' do
          post :create, params: { folder: folder_params }

          expect(find_folder).not_to be_nil
          expect(find_folder.name).to eq(folder_params[:name])
          expect(find_folder.folder_id).to eq(second_exists_folder.id)
        end
      end

      context 'three exists folder' do
        let!(:second_exists_folder) { Folder.create(name: 'other', folder_id: first_exists_folder.id) }
        let!(:third_exists_folder) { Folder.create(name: 'other', folder_id: second_exists_folder.id) }
        let(:folder_params) { { name: 'other', relative_path: 'other/other/other/other' } }
        let(:find_folder) { Folder.find_by(name: 'other', Folder_id: third_exists_folder.id) }

        it 'should be successful' do
          expect do
            post :create, params: { folder: folder_params }
          end.to change(Folder, :count).by(1)
        end

        it 'should create a new folder' do
          post :create, params: { folder: folder_params }

          expect(find_folder).not_to be_nil
          expect(find_folder.name).to eq(folder_params[:name])
          expect(find_folder.folder_id).to eq(third_exists_folder.id)
        end
      end
    end
  end
end
