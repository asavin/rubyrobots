# Utilizing this little gem 
# to help us with the user input
require 'highline/import'

# Our classes
require './robot'
require './world'

# Initializing values
@exit_commands = ['x', 'X', 'exit', 'EXIT', 'n', 'N']
@exit_command = []

# Array for storing command sequences for all robots
@robots = []
@robo_inputs = []

@new_robot_command = []

# Main app loop
while !@exit_commands.include?( @exit_command[0] )
  @robo_inputs.clear
  @robots.clear
  
  puts "--------- GAME OF ROBOTS -----------"
  
  # Create a new world with proper dimensions
  @world_coordinates = ask(
    "Max coordinates of the world (X Y): <%= color('>', GREEN) %>  ",
    lambda { |str| str.split(/ \s*/) })
  
  @world = World.new({ :x => @world_coordinates[0].to_i, 
                       :y => @world_coordinates[1].to_i })
  
  # If validation of world coordinates fails, ask again
  while @world.max_coordinates.nil?
    puts 'Incorrect coordinates entered, try again'
    @world_coordinates = ask(
      "Max coordinates of the world (X Y): <%= color('>', GREEN) %>  ",
      lambda { |str| str.split(/ \s*/) })
  
    @world.set_max_coordinates({ :x => @world_coordinates[0].to_i, 
                                 :y => @world_coordinates[1].to_i })
  end
  
  puts "Now enter commands and positions for the desired amount of robots"
  
  while !@exit_commands.include?( @new_robot_command[0] )
    @init_position = ask(
      "Initial position (ex: 1 1 E): <%= color('>', GREEN) %>  ",
      lambda { |str| str.split(/ \s*/) })
      
    @command_sequence = ask(
      "Command sequence (ex: RFRFLFF): <%= color('>', GREEN) %>  ",
      lambda { |str| str.split(/ \s*/) })
    
    @new_robot_command = ask(
      "Input another robot? ([Y]/n): <%= color('>', GREEN) %>  ",
      lambda { |str| str.split(/ \s*/) })
  
  end
  
  @exit_command = ask(
    "Exit or try again? (x/[A]): <%= color('>', GREEN) %>  ",
    lambda { |str| str.split(/ \s*/) })
  
  
end

puts "Goodbye!"