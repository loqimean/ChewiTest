require 'rails_helper'

RSpec.describe UsersIndex do
  let(:test_city) { City.create!(name: 'Kyiv') }
  let!(:test_user) do
    User.create!(name: 'John', email: 'jo@mail.io', city: test_city)
  end
  let(:finded_user) do
    described_class.query(query_string: {
      fields: [:name, :email], query: 'John' }).to_a[0]
  end

  before do
    described_class.reset!
  end

  context 'when user' do
    it 'exists' do
      expect(finded_user).not_to eq(nil)
    end

    it 'not exists' do
      User.last.destroy
      expect(finded_user) == nil
    end
  end

  context 'when searching by name' do
    let(:finded_user_in_lowercase) do
      described_class.query(query_string: {
        fields: [:name, :email], query: 'john' }).to_a[0]
    end

    it do
      expect(finded_user.name).to eq('John')
    end

    it 'in lowercase' do
      expect(finded_user_in_lowercase.name).to eq('John')
    end
  end

  context 'when searching by email' do
    let(:finded_user) do
      described_class.query(query_string: {
        fields: [:name, :email], query: 'jo@mail.io' }).to_a[0]
    end

    it do
      expect(finded_user.name).to eq('John')
    end
  end
end
