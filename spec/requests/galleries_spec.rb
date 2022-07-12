require 'rails_helper'

RSpec.describe GalleriesController, :type => :controller do
  before do
    user = User.create(email: 'admin@example.com', name: 'HaiLe', password: '123456')
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end

  let!(:gallery) do
    @gallery = Gallery.create(name: 'Gallery Test 1', description: 'TestCase')
  end

  describe 'GET /index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /create' do
    it 'responds to html by default' do
      post :create, params: { gallery: { name: 'Gallery 1', description: 'Description 1' } }
      expect(response.content_type).to eq 'text/html'
    end
  end

  describe 'POST /create' do
    it 'responds to error when name null' do
      post :create, params: { gallery: { name: '', description: 'Description 1' } }
      expect(response).to have_http_status(422)
    end
  end

  describe 'GET /show' do
    it 'responds to error when name null' do
      get :show, params: { id: @gallery.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /edit' do
    it 'responds to error when name null' do
      get :edit, params: { id: @gallery.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH /update' do
    it 'responds to error when name null' do
      patch :update, params: { id: @gallery.id, gallery: { name: 'New Gallery Test 1', description: 'Description 1' } }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to("/galleries/#{@gallery.id}")
    end
  end

  describe 'DELETE /destroy' do
    it 'responds to error when name null' do
      delete :destroy, params: { id: @gallery.id }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/galleries')
    end
  end
end
