# ex7.rb
# Create a class 'Student' with attributes name and
# grade. Do NOT make the grade getter public, so
# joe.grade will raise an error. Create a
# better_grade_than? method, that you can call.

class Student
  def initialize(g, n)
    @grade = g
    @name = n
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end
end

bob = Student.new(90, "Robert P. Donahue, III")
joe = Student.new(94, "Joseph Randolph")
puts "Well done!" if joe.better_grade_than?(bob)