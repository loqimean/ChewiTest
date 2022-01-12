require 'rails_helper'

RSpec.describe FileManager do
  let(:path) { 'a/b/c' }

  context ':find_by_path' do
    it 'should return record by path' do
      new_folder = Folder.find_or_create_by_path(path)
      folder = described_class.find_by_path(path)

      expect(folder).not_to be_nil
      expect(folder).to eq(new_folder)
    end

    context 'when returned one' do
      it 'DIRECTORY should return record' do
        Folder.find_or_create_by_path('a')

        found = described_class.find_by_path('a')

        expect(found.name).to eq('a')
        expect(found.class).to eq(Folder)
      end

      it 'FILE should return record' do
        Item.create(name: 'a', attachment: Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/test.txt"))

        found = described_class.find_by_path('a')

        expect(found.name).to eq('a')
        expect(found.class).to eq(Item)
      end
    end

    it 'should return nil if record not exists' do
      Folder.find_or_create_by_path('a/b/')

      folder = described_class.find_by_path(path)

      expect(folder).to be_nil
    end
  end
end
