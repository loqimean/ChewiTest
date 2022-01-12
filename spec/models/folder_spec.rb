require 'rails_helper'

RSpec.describe Folder, type: :model do
  let(:path) { 'a/b/c' }

  describe '#relations' do
    context 'has_many' do
      context ':folders' do
        it 'should remove children after destroying' do
          first_folder = Folder.create(name: 'a')
          second_folder = Folder.create(name: 'b', parent: first_folder)
          third_folder = Folder.create(name: 'c', parent: second_folder)

          expect(first_folder.children).to eq([second_folder])

          first_folder.destroy

          expect(first_folder.children).to be_empty
          expect(second_folder.children).to be_empty
          expect(Folder.find_by_name(third_folder.name)).to be_nil
        end
      end

      context ':items' do
        it 'should remove children after destroying' do
          first_folder = Folder.create(name: 'a')
          second_folder = Folder.create(name: 'b', parent: first_folder)

          file = Item.create(name: 'test.txt',
                             folder: second_folder,
                             attachment: Rack::Test::UploadedFile.new(
                               "#{Rails.root}/spec/files/test.txt"
                             )
                            )

          expect(first_folder.children).to eq([second_folder])

          first_folder.destroy

          expect(first_folder.children).to be_empty
          expect(second_folder.items).to be_empty
          expect(Item.find_by_name(file.name)).to be_nil
        end
      end
    end
  end

  describe '#validations' do
    context 'uniqueness of :name' do
      it 'shouldn\'t allow to create when file with same name exists' do
        folder_id = Folder.find_or_create_by_path(path)

        Item.create!(name: 'Gemfile',
                     folder_id: folder_id,
                     attachment: Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/test.txt"))

        expect(Folder.find_or_create_by_path("#{path}/Gemfile")).to be_nil
      end
    end
  end

  describe '#methods' do
    context ':relative_path' do
      it 'should return string of path by relation' do
        first_folder = Folder.create(name: 'a')
        second_folder = Folder.create(name: 'b', parent: first_folder)
        third_folder = Folder.create(name: 'c', parent: second_folder)

        expect(first_folder.relative_path).to eq('a')
        expect(second_folder.relative_path).to eq('a/b')
        expect(third_folder.relative_path).to eq(path)
      end
    end

    context ':find_or_create_by_path' do
      context 'when names is valid' do
        it 'should create folders by paths' do
          folder_id = Folder.find_or_create_by_path(path)
          folder = Folder.find(folder_id)

          expect(folder).to be_present
          expect(folder.parent.name).to eq('b')
          expect(folder.relative_path).to eq(path)
        end

        it 'should return last folder :id' do
          folder_id = Folder.find_or_create_by_path(path)

          expect(folder_id).to be_present
        end
      end
      context 'when names is invalid' do
        it 'should return nil when file with same name exist' do
          # Create parent folder and file
          folder_id = Folder.find_or_create_by_path(path.split('/')[0..-2])
          Item.create!(name: path.split('/').last, folder_id: folder_id, attachment: Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/test.txt"))

          # Try to create folder with folder name as has file
          duplicate_folder_id = Folder.find_or_create_by_path(path)

          expect(duplicate_folder_id).to be_nil
        end
      end
    end

    context ':find_by_path' do
      it 'should return record by path' do
        new_folder_id = Folder.find_or_create_by_path(path)
        new_folder = Folder.find(new_folder_id)
        folder = Folder.find_by_path(path)

        expect(folder).not_to be_nil
        expect(folder).to eq(new_folder)
      end

      context 'when returned one' do
        it 'DIRECTORY should return record' do
          Folder.find_or_create_by_path('a')

          found = Folder.find_by_path('a')

          expect(found.name).to eq('a')
          expect(found.class).to eq(described_class)
        end

        it 'FILE should return record' do
          Item.create(name: 'a', attachment: Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/test.txt"))

          found = Folder.find_by_path('a')

          expect(found.name).to eq('a')
          expect(found.class).to eq(Item)
        end
      end

      it 'should return nil if record not exists' do
        Folder.find_or_create_by_path('a/b/')

        folder = Folder.find_by_path(path)

        expect(folder).to be_nil
      end
    end
  end
end
