require 'rails_helper'

RSpec.describe Gallery, type: :model do
  it 'is not valid with valid attributes all null' do
    expect(Gallery.new).to be_invalid
  end

  it 'is not valid without a name' do
    gallery = Gallery.new(name: nil)
    expect(gallery).to be_invalid
  end

  it 'is valid with valid attributes name not null' do
    gallery = Gallery.new(name: 'Gallery Test 1')
    expect(gallery).to be_valid
  end

  it 'is return false because name unique' do
    Gallery.create(name: 'Gallery Test 1', description: 'Test')
    expect(Gallery.create(name: 'Gallery Test 1', description: 'Test').validate).to eq(false)
  end
end
