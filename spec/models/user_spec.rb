require 'rails_helper'

RSpec.describe User, type: :model do
  let(:test_city) { create(:city) }
  let(:test_user) { build(:user, city: test_city) }

  describe '#associations' do
    it { should belong_to(:city) }
  end

  describe '#validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:seniority) }
    it { should validate_presence_of(:email) }

    it { should validate_length_of(:name).is_at_least(2).is_at_most(50) }
    it { should validate_length_of(:seniority).is_at_least(2).is_at_most(50) }
    it { should validate_length_of(:email).is_at_least(5).is_at_most(255) }

    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should allow_value('test@mail.io').for(:email) }
    it { should_not allow_value('testmailio').for(:email) }
  end
end
