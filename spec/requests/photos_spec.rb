require 'rails_helper'

RSpec.describe PhotosController, :type => :controller do
  before do
    user = User.create(email: 'admin@example.com', name: 'HaiLe', password: '123456')
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end

  let!(:gallery) do
    @gallery = Gallery.create(name: 'Gallery For Photos', description: 'Gallery for photos description')
  end

  let!(:photo1) do
    @photo1 = Photo.new(name: 'Photo Test 1', description: 'Test', gallery_id: @gallery.id)
    @photo1.image.attach(
      io: File.open(Rails.root.join('spec', 'fixtures', 'default.jpeg')),
      filename: 'text.txt',
      content_type: 'application/text'
    )
    @photo1.save!
  end

  let!(:photo2) do
    @photo2 = Photo.new(name: 'Photo Test 2', description: 'Test2', gallery_id: @gallery.id)
    @photo2.image.attach(
      io: File.open(Rails.root.join('spec', 'fixtures', 'img.jpeg')),
      filename: 'text.txt',
      content_type: 'application/text'
    )
    @photo2.save!
  end

  describe 'GET /index' do
    it 'has a 200 status code' do
      get :index, params: { gallery_id: @gallery.id }
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /create' do
    it 'responds to html by default' do
      data = {
        name: 'Photo',
        shooting_date: Date.today,
        description: 'Test',
        gallery_id: @gallery,
        image: Rack::Test::UploadedFile.new(File.open(Rails.root.join('spec', 'fixtures', 'default.jpeg')))
      }
      post :create, params: { gallery_id: @gallery.id, photo: data }
      expect(response.content_type).to eq 'text/html'
    end
  end

  describe 'POST /create' do
    it 'responds to error when name null' do
      data = {
        name: '',
        shooting_date: Date.today,
        description: 'Test',
        gallery_id: @gallery,
        image: Rack::Test::UploadedFile.new(File.open(Rails.root.join('spec', 'fixtures', 'default.jpeg')))
      }
      post :create, params: { gallery_id: @gallery.id, photo: data }
      expect(response).to have_http_status(422)
    end
  end

  describe 'GET /show' do
    it 'responds to html by show actions' do
      get :show, params: { gallery_id: @gallery.id, id: @photo1.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /edit' do
    it 'responds to html by edit action' do
      get :edit, params: { gallery_id: @gallery.id, id: @photo1.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH /update' do
    it 'responds to status update success and redirect to template right' do
      data = {
        name: 'New Gallery Photo Test 1',
        shooting_date: Date.today,
        description: 'Test',
        gallery_id: @gallery.id,
        image: Rack::Test::UploadedFile.new(File.open(Rails.root.join('spec', 'fixtures', 'default.jpeg')))
      }
      patch :update, params: { gallery_id: @gallery.id, id: @photo1.id, photo: data }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to("/galleries/#{@gallery.id}/photos/#{@photo1.id}")
    end
  end

  describe 'DELETE /destroy' do
    it 'responds to destroy photo successfully' do
      delete :destroy, params: { gallery_id: @gallery.id, id: @photo1.id }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to("/galleries/#{@gallery.id}/photos")
    end
  end
end
