# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  # Remember: `has_many` is just a method where the first argument is the name
  # of the association and the second argument is an options hash.
  #
  # Note that Rails will accept either symbols or strings as values for
  # `class_name`, `foreign_key`, and `primary_key`.
  has_many :enrollments,
    class_name: 'Enrollment',
    foreign_key: :student_id,
    primary_key: :id

  has_many :enrolled_courses,
    through: :enrollments,
    source: :course
end