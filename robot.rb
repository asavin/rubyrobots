class Robot  
  ORIENTATION = ['N', 'E', 'S', 'W']
  COMMANDS = ['L', 'R', 'F']
  
  def initialize(start_position, command_sequence)
    @@position = nil
    @@sequence = nil
    
    set_start_position(start_position)
    set_command_sequence(command_sequence)
  end
  
  def set_start_position(position)
    position[:orientation].upcase!
    if validate_position(position)
      @@position = position
    end
  end
  
  def start_position
    @@position
  end
  
  def set_command_sequence(sequence)
    sequence.upcase!
    if validate_command_sequence(sequence)
      @@sequence = sequence
    end
  end
  
  def command_sequence
    @@sequence
  end
  
  def calculate_position(world)
    
  end
  
private
  def validate_position(position)
    if position.is_a?(Hash) &&
       position[:x].is_a?(Integer) && 
       position[:y].is_a?(Integer) &&
       ORIENTATION.include?(position[:orientation])
        position[:x] >= 0 && position[:y] >= 0
    else
      false
    end
  end
  
  def validate_command_sequence(sequence)
    if sequence.is_a?(String) &&
       sequence.length < 100
       sequence.each_char do |c|
         unless COMMANDS.include?(c)
           return false
         end
       end
    else
      false
    end
  end
end