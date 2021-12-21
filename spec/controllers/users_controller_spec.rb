require 'rails_helper'

RSpec.describe UsersController do
  context 'GET #index' do
    it 'should be success' do
      get :index

      expect(response.status).to eq(200)
    end
  end

  # context 'GET #show' do
    # it 'should be success' do
    #   get :show, params: { id: 1 }

    #   expect(response.status).to eq(200)
    # end
  # end

  context 'GET #new' do
    it 'should be success' do
      get :new

      expect(response.status).to eq(200)
    end
  end

  # context 'POST #create' do
    # it 'should be success' do
    #   post :create, params: { .. }

    #   expect(response.status).to eq(200)
    # end
  # end
end
