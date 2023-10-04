# == Schema Information
#
# Table name: courses
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  prereq_id     :bigint
#  instructor_id :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Course < ApplicationRecord
  # Remember: `has_many` and `belongs_to` are just methods where the first
  # argument is the name of the association and the second argument is an
  # options hash.
  #
  # Note that Rails will accept either symbols or strings as values for
  # `class_name`, `foreign_key`, and `primary_key`.
  has_many :enrollments,
    class_name: 'Enrollment',
    foreign_key: :course_id,
    primary_key: :id

  has_many :enrolled_students,
    through: :enrollments,
    source: :student

  # By default, Rails automatically validates the presence of a `belongs_to`
  # association. Since some courses will not have a prerequisite, you need to
  # turn off this default behavior for the prerequisite association by
  # specifying that it is `optional`. 
  belongs_to :prerequisite,
    class_name: 'Course',
    foreign_key: :prereq_id,
    primary_key: :id,
    optional: true

  belongs_to :instructor,
    class_name: 'User',
    foreign_key: :instructor_id,
    primary_key: :id
end