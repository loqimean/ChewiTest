require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe '#methods' do
    context 'relative_path' do
      it 'should return string of path by relation' do
        first_folder = Folder.create(name: 'a')
        second_folder = Folder.create(name: 'b', parent: first_folder)
        third_folder = Folder.create(name: 'c', parent: second_folder)

        expect(third_folder.relative_path).to eq('a/b/c')
      end
    end
  end

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
end
