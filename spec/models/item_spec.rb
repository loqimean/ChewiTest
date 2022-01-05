require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#methods' do
    context 'relative_path' do
      it 'should return string of path by relation' do
        first_folder = Folder.create(name: 'd')
        second_folder = Folder.create(name: 'e', parent: first_folder)
        third_folder = Folder.create(name: 'f', parent: second_folder)

        file = Item.create(name: 'test.txt',
                           folder: third_folder,
                           attachment: Rack::Test::UploadedFile.new(
                             "#{Rails.root}/spec/files/test.txt"
                            )
                          )

        expect(file.relative_path).to eq('d/e/f/test.txt')
      end
    end
  end
end
