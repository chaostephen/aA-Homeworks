# == Schema Information
#
# Table name: people
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  house_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Person < ApplicationRecord
  # Remember: Rails automatically validates the presence of `belongs_to`
  # associations, so do not validate the presence of `house` (or `house_id`).
  validates :name, presence: true

  # Remember: `belongs_to` is just a method where the first argument is the name
  # of the association and the second argument is an options hash.
  belongs_to :house,
    primary_key: :id,
    foreign_key: :house_id,
    class_name: :House
end