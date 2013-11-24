# Utilizing this little gem 
# to help us with the user input
require 'highline/import'

# Our classes
require './robot'

# Initializing values
@exit_commands = ['x', 'X', 'exit', 'EXIT']

# Main app loop
while (!@exit_commands.include?(@input[0]))
  
  # We should support multiple robots inputs here
  
  puts "--------- New command sequence --------------"
  @world_coordinates = ask("Upper right coordinates: <%= color('>', GREEN) %>  ", lambda { |str| str.split(/ \s*/) })
  @init_position = ask("Initial position (ex: 1 1 E): <%= color('>', GREEN) %>  ", lambda { |str| str.split(/ \s*/) })
  @command_sequenceask = ("Command sequence (ex: RFRFLFF): <%= color('>', GREEN) %>  ", lambda { |str| str.split(/ \s*/) })
  
end

puts "Goodbye!"