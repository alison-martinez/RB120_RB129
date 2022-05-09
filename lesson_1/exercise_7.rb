class Student
  attr_accessor :name
  attr_writer :grade

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(student2)
    grade > student2.grade
  end

  protected

  def grade
    @grade
  end
end

joe = Student.new("Joe", 98)
bob = Student.new("Bob", 90)

puts "Well done!" if joe.better_grade_than?(bob)

