# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint           not null, primary key
#  course_id  :bigint           not null
#  student_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Enrollment < ApplicationRecord
  # Remember: `belongs_to` is just a method where the first argument is the name
  # of the association and the second argument is an options hash.
  #
  # Note that Rails will accept either symbols or strings as values for
  # `class_name`, `foreign_key`, and `primary_key`. 
  belongs_to :student,
    class_name: 'User',
    foreign_key: :student_id,
    primary_key: :id

  belongs_to :course,
    class_name: 'Course',
    foreign_key: :course_id,
    primary_key: :id
end