class Person
  def name=(name)
    @name = name.capitalize
  end

  def name
    @name
  end

end

person1 = Person.new
person1.name = 'eLiZaBeTh'
puts person1.name