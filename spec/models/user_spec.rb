require 'rails_helper'

RSpec.describe User, type: :model do
  let(:test_city) { City.create!(name: 'Kyiv') }
  let(:test_user) do
    User.new(name: 'Nikolas', email: 'nik@mail.io', city: test_city)
  end

  context 'whith' do
    it 'valid attributes' do
      expect(test_user).to be_valid
    end
  end

  context 'when name' do
    it 'length too short' do
      test_user.name = 'q'
      expect(test_user).not_to be_valid
    end

    it 'length too long' do
      test_user.name = 'q' * 51
      expect(test_user).not_to be_valid
    end
  end

  context 'without presence' do
    it 'name not valid' do
      test_user.name = nil
      expect(test_user).not_to be_valid
    end

    it 'email not valid' do
      test_user.email = nil
      expect(test_user).not_to be_valid
    end

    it 'city not valid' do
      test_user.city = nil
      expect(test_user).not_to be_valid
    end
  end

  context 'when email' do
    it 'already been taken' do
      User.create(name: test_user.name, email: test_user.email, city: test_city)
      expect(test_user).not_to be_valid
    end

    it 'length too long' do
      test_user.name = 'q' * 256
      expect(test_user).not_to be_valid
    end

    it 'length too short' do
      test_user.email = 'q' * 4
      expect(test_user).not_to be_valid
    end

    it 'has incorrect format' do
      test_user.email = 'test'
      expect(test_user).not_to be_valid
    end
  end
end
