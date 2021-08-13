require 'rails_helper'

RSpec.describe UsersIndex do
  let!(:test_user) { User.create!(name: 'John', email: 'jo@mail.io') }

  before do
    UsersIndex.reset!
  end

  context 'when user' do
    let(:finded_user) do
      UsersIndex.query(query_string: {
        fields: [:name, :email], query: 'John' }).to_a[0]
    end

    it 'exists' do
      expect(finded_user).not_to eq(nil)
    end

    it 'not exists' do
      User.last.destroy
      expect(finded_user) == nil
    end
  end

  context 'when search by name' do
    let(:finded_user) do
      UsersIndex.query(query_string: {
        fields: [:name, :email], query: 'John' }).to_a[0]
    end

    it do
      expect(finded_user.name).to eq('John')
    end
  end

  context 'when search by email' do
    let(:finded_user) do
      UsersIndex.query(query_string: {
        fields: [:name, :email], query: 'jo@mail.io' }).to_a[0]
    end

    it do
      expect(finded_user.name).to eq('John')
    end
  end
end
