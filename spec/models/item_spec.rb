require 'rails_helper'

RSpec.describe Item, type: :model do
  let!(:valid_test_folder) { Folder.create(name: 'Test') }
  let!(:valid_test_item) { Item.create(attachment: File.open("#{Rails.root}/spec/files/test.txt"), folder: valid_test_folder) }

  context 'validations' do
    describe 'with validation presence of' do
      context 'attachment' do
        let(:not_valid_test_item) { Item.new }

        it 'should be valid' do
          expect(valid_test_item).to be_valid
        end

        it 'should not be valid without' do
          expect(not_valid_test_item).not_to be_valid
        end
      end
    end
  end

  context 'callbacks' do
    describe '#set_file_name' do
      it 'should set the file name' do
        expect(valid_test_item.file_name).to eq('test.txt')
      end
    end
  end
end
