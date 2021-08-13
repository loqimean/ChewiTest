require 'rails_helper'

RSpec.describe User, type: :model do
  let(:test_user) { User.new(name: 'Nikolas', email: 'nik@mail.io') }

  context 'whith' do
    it 'valid attributes' do
      expect(test_user).to be_valid
    end
  end

  context 'when not valid' do
    it 'name presence' do
      test_user.name = nil
      expect(test_user).not_to be_valid
    end

    it 'name length too short' do
      test_user.name = 'q'
      expect(test_user).not_to be_valid
    end

    it 'name length too long' do
      test_user.name = 'q' * 51
      expect(test_user).not_to be_valid
    end

    it 'email presence' do
      test_user.email = nil
      expect(test_user).not_to be_valid
    end

    it 'email length too long' do
      test_user.name = 'q' * 256
      expect(test_user).not_to be_valid
    end

    it 'email format' do
      test_user.email = 'test'
      expect(test_user).not_to be_valid
    end

    it 'email already been taken' do
      User.create(name: test_user.name, email: test_user.email)
      expect(test_user).not_to be_valid
    end
  end
end
