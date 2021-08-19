require 'rails_helper'

RSpec.describe "Cities", type: :request do
  let(:test_city) { City.create(name: 'Kyiv') }

  describe "GET /index" do
    it "returns http success" do
      get cities_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get edit_city_path(test_city)
      expect(response).to have_http_status(:success)
    end
  end
end
