# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  author_id  :bigint           not null
#  artwork_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
  # Remember: Rails automatically validates the presence of `belongs_to`
  # associations, so you can omit presence validations for `author` and
  # `artwork` and their associated foreign keys.
  validates :body, presence: true

  belongs_to :author, class_name: :User
  belongs_to :artwork
  has_many :likes, as: :likeable, dependent: :destroy
end