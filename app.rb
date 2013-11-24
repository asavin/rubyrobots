# Utilizing this little gem 
# to help us with the user input
require 'highline/import'

# Our classes
require './robot'
require './world'

# Initializing values
EXIT_COMMANDS = ['x', 'X', 'exit', 'EXIT', 'n', 'N']
@exit_command = []

# Array for storing command sequences for all robots
@robots = []
@new_robot_command = []

# Main app loop
while !EXIT_COMMANDS.include?( @exit_command[0] )
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
  
  while !EXIT_COMMANDS.include?( @new_robot_command[0] )
    @init_position = ask(
      "Initial position (ex: 1 1 E): <%= color('>', GREEN) %>  ",
      lambda { |str| str.split(/ \s*/) })
      
    @command_sequence = ask(
      "Command sequence (ex: RFRFLFF): <%= color('>', GREEN) %>  ",
      lambda { |str| str.split(/ \s*/) })
    
      robot = Robot.new({:x => @init_position[0].to_i, 
                         :y => @init_position[1].to_i, 
                         :orientation => @init_position[2]},
                         @command_sequence[0])
                         
      while robot.position.nil?
        puts "Incorrect initial position. Please try again."
        @init_position = ask(
          "Initial position (ex: 1 1 E): <%= color('>', GREEN) %>  ",
          lambda { |str| str.split(/ \s*/) })
          
          robot.set_start_position({:x => @init_position[0].to_i, 
                                    :y => @init_position[1].to_i, 
                                    :orientation => @init_position[2]})
      end
      
      while robot.command_sequence.nil?
        puts "Incorrect command sequence. Please try again."
        @command_sequence = ask(
          "Command sequence (ex: RFRFLFF): <%= color('>', GREEN) %>  ",
          lambda { |str| str.split(/ \s*/) })
          
          robot.set_command_sequence(@command_sequence[0])
      end
      
      # Pushing validated robot into the command stack
      @robots << robot
    
    
    @new_robot_command = ask(
      "Input another robot? ([Y]/n): <%= color('>', GREEN) %>  ",
      lambda { |str| str.split(/ \s*/) })
  
  end
  
  # All ready, calculate positions for every robot
  # and print out results
  puts "\n\nCalculating positions for each robot"
  @robots.each do |robot|
    robot.calculate_position(@world)
    puts "\n#{robot.position[:x]} #{robot.position[:y]} #{robot.position[:orientation]}"
    if robot.position[:lost]
      puts "LOST"
    end
  end
  
  @exit_command = ask(
    "Exit or try again? (x/[A]): <%= color('>', GREEN) %>  ",
    lambda { |str| str.split(/ \s*/) })
  
  
end

puts "Goodbye!"