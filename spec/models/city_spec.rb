require 'rails_helper'

RSpec.describe City, type: :model do
  let(:test_city) { City.new(name: 'Kyiv') }

  context 'whith' do
    it 'valid attributes' do
      expect(test_city).to be_valid
    end
  end

  context 'when name' do
    it 'too short' do
      test_city.name = 'q'
      expect(test_city).not_to be_valid
    end

    it 'too long' do
      test_city.name = 'q' * 51
      expect(test_city).not_to be_valid
    end

    it 'has valid length' do
      test_city.name = 'q' * 20
      expect(test_city).to be_valid
    end
  end
end
