# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  username   :string           not null
#
class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :artworks,
    foreign_key: :artist_id,
    dependent: :destroy,
    inverse_of: :artist
  has_many :artwork_shares,
    foreign_key: :viewer_id,
    dependent: :destroy,
    inverse_of: :viewer
  has_many :shared_artworks,
    through: :artwork_shares,
    source: :artwork
  has_many :comments,
    foreign_key: :author_id,
    dependent: :destroy,
    inverse_of: :author
  has_many :likes,
    foreign_key: :liker_id,
    dependent: :destroy,
    inverse_of: :liker
  has_many :liked_comments,
    through: :likes,
    source: :likeable,
    source_type: 'Comment'
  has_many :liked_artworks,
    through: :likes,
    source: :likeable,
    source_type: 'Artwork'
  has_many :collections,
    dependent: :destroy

  def favorite_artworks
    artworks.where(favorite: true)
  end

  def favorite_shared_artworks
    shared_artworks.where('artwork_shares.favorite = true')
  end
end