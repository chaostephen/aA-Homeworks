# == Schema Information
#
# Table name: artwork_shares
#
#  id         :bigint           not null, primary key
#  artwork_id :bigint           not null
#  viewer_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  favorite   :boolean          default(FALSE)
#
class ArtworkShare < ApplicationRecord
  # Remember: Rails automatically validates the presence of `belongs_to`
  # associations, so you can omit the presence validations.
  validates :viewer_id, uniqueness: { scope: :artwork_id }
  validates :favorite, inclusion: { in: [true, false] }

  belongs_to :artwork, inverse_of: :artwork_shares
  belongs_to :viewer, class_name: 'User', inverse_of: :artwork_shares
end