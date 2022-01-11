require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#validations' do
    context 'uniqueness of :name' do
      it 'shouldn\'t allow to create when folder with same name exists' do
        parent_id = Folder.find_or_create_by_path('a/b/c')
        folder_id = Folder.create(name: 'Gemfile', folder_id: parent_id)

        file = Item.new(name: 'Gemfile',
                           folder_id: parent_id,
                           attachment: Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/test.txt"))

        expect(file.valid?).to be_falsey
      end
    end
  end

  describe '#methods' do
    context 'relative_path' do
      it 'should return string of path by relation' do
        first_folder = Folder.create(name: 'd')
        second_folder = Folder.create(name: 'e', parent: first_folder)
        third_folder = Folder.create(name: 'f', parent: second_folder)

        file_with_folder = Item.create(name: 'test.txt',
                                       folder: third_folder,
                                       attachment: Rack::Test::UploadedFile.new(
                                         "#{Rails.root}/spec/files/test.txt"
                                        )
                                      )
        file_without_folder = Item.create(name: 'test.txt',
                                          attachment: Rack::Test::UploadedFile.new(
                                            "#{Rails.root}/spec/files/test.txt"
                                          )
                                        )

        expect(file_with_folder.relative_path).to eq('d/e/f/test.txt')
        expect(file_without_folder.relative_path).to eq('test.txt')
      end
    end
  end
end
