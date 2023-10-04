# == Schema Information
#
# Table name: collections
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Collection < ApplicationRecord
  # Remember: Rails automatically validates the presence of `belongs_to`
  # associations, so you can omit presence validations for `user` and its
  # foreign key.
  validates :name, presence: true

  belongs_to :user
  has_many :artwork_collections,
    dependent: :destroy
  has_many :artworks,
    through: :artwork_collections,
    source: :artwork
end