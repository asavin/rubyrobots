# Utilizing this little gem 
# to help us with the user input
require 'highline/import'

# Our classes
require './robot'

# Initializing values
@exit_commands = ['x', 'X', 'exit', 'EXIT', 'n', 'N']
@exit_command = []

# Array for storing command sequences for all robots
@robots = []

@new_robot_command = []

# Main app loop
while (!@exit_commands.include?(@exit_command[0]))
  @robo_inputs.clear
  @robots.clear
  
  puts "--------- GAME OF ROBOTS -----------"
  @world_coordinates = ask("Max coordinates of the world (X Y): <%= color('>', GREEN) %>  ", lambda { |str| str.split(/ \s*/) })
  
  @world = World.new({:x => @world_coordinates[0], :y => @world_coordinates[1]})
  
  puts "--- Now enter commands and positions for the desired amount of robots ---"
  
  while !@exit_commands.include?(@new_robot_command[0])
    @init_position = ask("Initial position (ex: 1 1 E): <%= color('>', GREEN) %>  ", lambda { |str| str.split(/ \s*/) })
    @command_sequence = ask("Command sequence (ex: RFRFLFF): <%= color('>', GREEN) %>  ", lambda { |str| str.split(/ \s*/) })
    
    @new_robot_command = ask("Input another robot? ([Y]/n): <%= color('>', GREEN) %>  ", lambda { |str| str.split(/ \s*/) })
  
    
  end
  
  @exit_command = ask("Exit or try again? (x/[A]): <%= color('>', GREEN) %>  ", lambda { |str| str.split(/ \s*/) })
  
  
end

puts "Goodbye!"