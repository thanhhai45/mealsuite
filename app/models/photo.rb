class Photo < ApplicationRecord
  belongs_to :gallery
  has_one_attached :image

  validates :name, presence: true
  validates :image, presence: true
  validates_uniqueness_of :name
  validate :image_format

  private

  def image_format
    errors.add(:image, 'Should be image type [jpeg,png,gif,jpg,svg]') unless image.image?
  end
end
