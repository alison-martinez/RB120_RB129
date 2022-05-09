class Cat
  attr_accessor :name
  @@total = 0

  def self.generic_greeting
    puts "Hello! I am a Cat!"
  end

  def self.total
    puts @@total
  end
  
  def personal_greeting
    puts "Hello! My name is #{name}!"
  end

  def initialize(name)
    @name = name
    @@total += 1
  end

  def rename(new_name)
    self.name = new_name
  end

  def identify
    self
  end
end


kitty1 = Cat.new("Sophie")
kitty2 = Cat.new("Daphne")

Cat.total