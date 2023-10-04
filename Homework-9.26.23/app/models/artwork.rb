# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  favorite   :boolean          default(FALSE)
#
class Artwork < ApplicationRecord
  # Remember: Rails automatically validates the presence of `belongs_to`
  # associations, so you can omit `artist` and its foreign key from the presence
  # validation.
  validates :title, :image_url, presence: true
  validates :image_url, uniqueness: true
  validates :title, uniqueness: { scope: :artist_id }

  belongs_to :artist,
    class_name: 'User'
  has_many :artwork_shares,
    dependent: :destroy
  has_many :shared_viewers,
    through: :artwork_shares,
    source: :viewer
  has_many :comments,
    dependent: :destroy
  has_many :likes,
    as: :likeable,
    dependent: :destroy
  has_many :artwork_collections,
    dependent: :destroy

  # Class method to return all artworks made by OR shared with the user
  def self.artworks_for_user_id(user_id)
    Artwork
      .left_outer_joins(:artwork_shares)
      .where('(artworks.artist_id = :user_id) OR (artwork_shares.viewer_id = :user_id)', user_id: user_id)
      .distinct
  end

  def self.artworks_for_collection_id(collection_id)
    Artwork.joins(:artwork_collections).where(artwork_collections: { collection_id: collection_id })
  end
end