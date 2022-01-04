require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  context 'POST #create' do
    let(:find_item) { Item.find_by_file_name('file.txt') }

    context 'when folder is root' do
      let(:item_params_in_root) do
        {
          name: 'file.txt',
          attachment: File.open("#{Rails.root}/spec/files/test.txt")
        }
      end

      it 'should be successful' do
        expect do
          post :create, params: { file: item_params_in_root }
        end.to change(Item, :count).by(1)
      end

      it 'should create a new item' do
        post :create, params: { file: item_params_in_root }

        expect(find_item).not_to be_nil
        expect(find_item.name).to eq(item_params_in_root[:name])
        expect(find_item.folder_id).to be_nil
      end
    end

    context 'when creates in' do
      let!(:first_exists_folder) { Folder.create(name: 'other') }

      context 'one exists folder' do
        let(:item_params_in_one_folder) do
          {
            name: 'file.txt',
            attachment: File.open("#{Rails.root}/spec/files/test.txt"),
            relative_path: 'other/file.txt'
          }
        end

        it 'should be successful' do
          expect do
            post :create, params: { file: item_params_in_one_folder }
          end.to change(Item, :count).by(1)
        end

        it 'should create a new item' do
          post :create, params: { file: item_params_in_one_folder }

          expect(find_item).not_to be_nil
          expect(find_item.name).to eq(item_params_in_one_folder[:name])
          expect(find_item.folder_id).to eq(first_exists_folder.id)
        end
      end

      context 'two exists folders' do
        let!(:second_exists_folder) do
          Folder.create(name: 'other', folder_id: first_exists_folder.id)
        end
        let(:item_params_in_one_folder) do
          {
            name: 'file.txt',
            attachment: File.open("#{Rails.root}/spec/files/test.txt"),
            relative_path: 'other/other/file.txt'
          }
        end

        it 'should be successful' do
          expect do
            post :create, params: { file: item_params_in_one_folder }
          end.to change(Item, :count).by(1)
        end

        it 'should create a new item' do
          post :create, params: { file: item_params_in_one_folder }

          expect(find_item).not_to be_nil
          expect(find_item.name).to eq(item_params_in_one_folder[:name])
          expect(find_item.folder_id).to eq(second_exists_folder.id)
        end
      end

      context 'three exists folders' do
        let!(:second_exists_folder) do
          Folder.create(name: 'other', folder_id: first_exists_folder.id)
        end
        let!(:third_exists_folder) do
          Folder.create(name: 'other', folder_id: second_exists_folder.id)
        end
        let(:item_params_in_one_folder) do
          {
            name: 'file.txt',
            attachment: File.open("#{Rails.root}/spec/files/test.txt"),
            relative_path: 'other/other/other/file.txt'
          }
        end

        it 'should be successful' do
          expect do
            post :create, params: { file: item_params_in_one_folder }
          end.to change(Item, :count).by(1)
        end

        it 'should create a new item' do
          post :create, params: { file: item_params_in_one_folder }

          expect(find_item).not_to be_nil
          expect(find_item.name).to eq(item_params_in_one_folder[:name])
          expect(find_item.folder_id).to eq(third_exists_folder.id)
        end
      end
    end
  end
end
