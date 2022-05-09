class Person
  attr_accessor :first_name, :last_name
  
  def initialize(name)
    parse_full_name(name)
  end

  def name
    @last_name == '' ? @first_name : (@first_name + " " + @last_name)
  end

    def name= (name)
      parse_full_name(name)
    end

    private

    def parse_full_name(name)
      full_name = name.split
      self.first_name = full_name.first
      self.last_name = full_name.size > 1 ? full_name.last : ''
    end



end



bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'