require 'rails_helper'

RSpec.describe Folder, type: :model do
  let!(:valid_test_folder) { Folder.create(name: 'Test') }

  context 'validations' do
    describe 'with validation presence of' do
      context 'name' do
        let(:invalid_test_folder) { Folder.new }

        it 'should be valid with name' do
          expect(valid_test_folder).to be_valid
        end

        it 'should not be valid without name' do
          expect(invalid_test_folder).not_to be_valid
        end
      end
    end

    describe 'with validation uniqueness of' do
      context 'name in scope of folder_id' do
        let!(:valid_test_root_folder) { Folder.create(name: 'Test') }
        let(:valid_test_first_child_folder) { Folder.new(name: 'a', folder_id: valid_test_root_folder.id) }
        let(:valid_test_second_child_folder) { Folder.new(name: 'b', folder_id: valid_test_root_folder.id) }
        let(:invalid_test_child_folder) { Folder.new(name: 'a', folder_id: valid_test_root_folder.id) }

        it 'should be valid' do
          expect(valid_test_first_child_folder.valid?).to be_truthy
          expect(valid_test_second_child_folder.valid?).to be_truthy
        end

        it 'shouldn\'t be valid with the same name' do
          valid_test_first_child_folder.save

          expect(invalid_test_child_folder.valid?).to be_falsey
        end
      end
    end
  end
end
