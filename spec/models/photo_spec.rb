require 'rails_helper'

RSpec.describe Photo, type: :model do
  before(:each) do
    @gallery = Gallery.create(name: 'Gallery Test 1', description: 'Test description')
    @photo = Photo.new(name: 'Photo Test 1', description: 'Test')
    @photo.image.attach(
      io: File.open(Rails.root.join('spec', 'fixtures', 'default.jpeg')),
      filename: 'text.txt',
      content_type: 'application/text'
    )
  end

  it 'is not valid with valid attributes all null' do
    expect(@photo).to be_invalid
  end

  it 'is not valid without a name' do
    @photo.name = nil
    expect(@photo).to be_invalid
  end

  it 'is valid with valid attributes name not null' do
    @photo.name = 'Photo Test 2'
    @photo.gallery_id = @gallery.id
    expect(@photo).to be_valid
  end

  it 'is return false because name unique' do
    @photo1 = Photo.new(name: 'Photo Test 1', description: 'Test')
    @photo1.image.attach(
      io: File.open(Rails.root.join('spec', 'fixtures', 'default.jpeg')),
      filename: 'text.txt',
      content_type: 'application/text'
    )
    @photo1.gallery_id = 1
    expect(@photo1.validate).to eq(false)
  end

  it 'is return false if upload not image type' do
    @gallery2 = Gallery.create(name: 'Gallery Test 2', description: 'Test description')
    @photo2 = Photo.new(name: 'Photo Test 2', description: 'Test')
    @photo2.image.attach(
      io: File.open(Rails.root.join('spec', 'fixtures', 'text.txt')),
      filename: 'text.txt',
      content_type: 'application/text'
    )
    @photo2.gallery_id = @gallery2.id
    @photo2.validate
    expect(@photo2.errors[:image].first).to eq('Should be image type [jpeg,png,gif,jpg,svg]')
  end
end
