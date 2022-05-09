module Towable
  def tow
    puts "I can tow!"
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :year
  attr_reader :model
  @@number_of_vehicles = 0
  
  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
    @@number_of_vehicles += 1
  end

  def self.number_of_vehicles
    puts "Number of vehicles is #{@@number_of_vehicles}."
  end


  def self.gas_mileage(miles, gallons)
    miles / gallons
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def speed_up(number)
    @speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def brake(number)
    @speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@speed} mph."
  end

  def turn_off
    @speed = 0
    puts "Let's park this bad boy!"
  end

  def spray_paint(color)
    self.color = color
    puts "The color of your #{model} is now #{color}."
  end

  def get_age
    puts "The age of the vehicle is #{age}."
  end

  private

  def age
    model_year = self.year
    current_year = Time.now.year
    current_year - model_year
  end

end

class MyCar < Vehicle
  TYPE = "car"

  def to_s
    "Your #{TYPE} is a #{color} #{year} #{model}."
  end
  
end

class MyTruck < Vehicle
  include Towable
  TYPE = "truck"

  def to_s
    "Your #{TYPE} is a #{color} #{year} #{model}."
  end
  
end

Vehicle.number_of_vehicles
fiat = MyCar.new(2015, "Fiat 500", "Green")
truck = MyTruck.new(2010, "Toyota", "Gray")
puts fiat
puts truck
Vehicle.number_of_vehicles
truck.tow
puts Vehicle.ancestors
puts MyCar.ancestors
puts MyTruck.ancestors
fiat.get_age
