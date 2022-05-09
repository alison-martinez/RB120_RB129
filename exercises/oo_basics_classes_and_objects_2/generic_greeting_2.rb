class Cat
  attr_accessor :name

  def self.generic_greeting
    puts "Hello! I am a Cat!"
  end
  
  def personal_greeting
    puts "Hello! My name is #{name}!"
  end

  def initialize(name)
    @name = name
  end

  def rename(new_name)
    self.name = new_name
  end

  def identify
    self
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting