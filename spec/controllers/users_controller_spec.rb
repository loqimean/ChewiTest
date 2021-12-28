require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  context 'GET #index' do
    # Check without city for #index
    let!(:test_city) { create(:city) }

    it 'should be success' do
      get :index

      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    context 'with format:' do
      context ':xlsx' do
        it do
          get :index, format: :xlsx

          expect(response).to be_successful
          expect(response).to render_template(:index)
        end

        it 'should have correct content type' do
          get :index, format: :xlsx

          expect(
            response.content_type
          ).to include('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        end
      end

      context ':xml' do
        it do
          get :index, format: :xml

          expect(response).to be_successful
          expect(response).not_to render_template(:index)
        end

        it 'should have correct content type' do
          get :index, format: :xml

          expect(
            response.content_type
          ).to include('application/xml')
        end

        it 'should have correct filename' do
          get :index, format: :xml

          expect(response.headers['Content-Disposition']).to include('users.xml')
        end
      end
    end
  end

  context 'GET #show' do
    let!(:test_user) { create(:user) }

    it do
      get :show, params: { id: test_user.id }

      expect(response).to be_successful
      expect(response).to render_template(:show)
    end
  end

  context 'GET #new' do
    it do
      get :new

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  context 'GET #edit' do
    let!(:test_user) { create(:user) }

    it do
      get :edit, params: { id: test_user.id }

      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end

  context 'POST #create' do
    let!(:test_city) { create(:city) }
    let(:attributes_for_user) do
      build(:user, email: 'test@mail.io').attributes.merge!(
        city_attributes: { name: test_city.name }
      )
    end
    let(:user) { User.find_by(email: 'test@mail.io') }

    it do
      expect do
        post :create, params: { user: attributes_for_user }, format: :turbo_stream
      end.to change(User, :count).by(1)

      expect(response).to be_successful
      expect(response).to render_template(:create)
    end

    it 'should create when city exists' do
      expect do
        post :create, params: { user: attributes_for_user }, format: :turbo_stream
      end.to change(User, :count).by(1)

      expect(user.city).to eq(test_city)
    end

    it 'shouldn\'t create without city' do
      expect do
        post :create, params: {
          user: attributes_for_user.except(:city_attributes)
        }, format: :turbo_stream
      end.not_to change(User, :count)
    end

    it 'should index users after creation' do
      post :create, params: { user: attributes_for_user }, format: :turbo_stream

      expect(
        UsersIndex.query(query_string: {fields: [:name, :email], query: User.first.email }).to_a[0]
      ).to eq(user)
    end

    it 'shouldn\'t allow when params is missing or incorrect' do
      expect do
        post :create, params: { user: { name: 'q' } }, format: :turbo_stream
      end.not_to change(User, :count)

      expect(response).to render_template(:create_has_errors)
    end
  end

  context 'PATCH #update' do
    let!(:test_user) { create(:user, email: 'test@mail.io') }

    it 'should succesfully update the user' do
      expect do
        patch :update , params: { id: test_user.id, user: { name: 'Nik' } }, format: :turbo_stream

        test_user.reload
      end.to change(test_user, :name)

      expect(response).to render_template(:update)
    end

    it 'should index users after updating' do
      patch :update , params: { id: test_user.id, user: { name: 'Nik' } }, format: :turbo_stream

      test_user.reload

      expect(
        UsersIndex.query(query_string: {fields: [:name, :email], query: test_user.email }).to_a[0].name
      ).to eq(test_user.name)
    end

    it 'should unsuccesfully update the user with invalid params' do
      expect do
        patch :update , params: { id: test_user.id, user: { name: 'N' } }, format: :turbo_stream

        test_user.reload
      end.not_to change(test_user, :name)

      expect(response).to render_template(:update_has_errors)
    end
  end

  context 'DELETE #destroy' do
    let!(:test_user) { create(:user, email: 'test@mail.io') }

    it 'should successfully destroy' do
      expect do
        delete :destroy, params: { id: test_user.id }, format: :turbo_stream
      end.to change(User, :count).by(-1)

      expect(response).to  render_template(:destroy)
    end

    it 'should index users after destroy' do
      delete :destroy, params: { id: test_user.id }, format: :turbo_stream

      expect(
        UsersIndex.query(query_string: {fields: [:name, :email], query: test_user.email }).to_a[0]
      ).to be_nil
    end
  end
end
