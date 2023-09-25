# == Schema Information
#
# Table name: houses
#
#  id         :bigint           not null, primary key
#  address    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class House < ApplicationRecord
  validates :address, presence: true

  # Remember: `has_many` is just a method where the first argument is the name
  # of the association and the second argument is an options hash.
  has_many :residents,
    primary_key: :id,
    foreign_key: :house_id,
    class_name: :Person
end