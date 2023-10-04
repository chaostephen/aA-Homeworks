# == Schema Information
#
# Table name: artwork_collections
#
#  id            :bigint           not null, primary key
#  collection_id :bigint           not null
#  artwork_id    :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class ArtworkCollection < ApplicationRecord
  # Remember: Rails automatically validates the presence of `belongs_to`
  # associations, so you can omit the presence validations here.
  validates :artwork_id, uniqueness: { scope: :collection_id }

  belongs_to :collection, inverse_of: :artwork_collections
  # You don't need `inverse_of` on `artwork` because `Artwork` does not use
  # `artwork_collections` in a `has_many :through` association.
  belongs_to :artwork
end