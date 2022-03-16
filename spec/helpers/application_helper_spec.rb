require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#clean_keys' do
    let!(:test_user) { build(:user) }

    it 'should return array of keys without :id, :created_at, :updated_at' do
      expect(self.clean_keys(test_user)).not_to include('id', 'created_at', 'updated_at')
    end
  end
end
