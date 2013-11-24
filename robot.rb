class Robot  
  ORIENTATION = ['N', 'E', 'S', 'W']
  COMMANDS = ['L', 'R', 'F']
  
  def initialize(start_position, command_sequence)
    @position = nil
    @sequence = nil
    
    set_start_position(start_position)
    set_command_sequence(command_sequence)
  end
  
  def set_start_position(position)
    if validate_position(position)
      position[:orientation].upcase!
      @position = position
    end
  end
  
  def position
    @position
  end
  
  def set_command_sequence(sequence)
    sequence.upcase!
    if validate_command_sequence(sequence)
      @sequence = sequence
    end
  end
  
  def command_sequence
    @sequence
  end
  
  def calculate_position(world)
    @sequence.each_char do |c|
      case c
      when 'L'
        turn_left
      when 'R'
        turn_right
      when 'F'
        unless position[:lost]
          increment_position(world)
        end
      else
      end
    end
  end
  
private
  def turn_left
    current_orientation_index = 
      ORIENTATION.index(@position[:orientation])
    
    if current_orientation_index > 0
      @position[:orientation] = ORIENTATION[current_orientation_index - 1]
    else
      @position[:orientation] = ORIENTATION.last      
    end
  end
  
  def turn_right
    current_orientation_index = 
      ORIENTATION.index(@position[:orientation])
    
    if current_orientation_index < ORIENTATION.length - 1
      @position[:orientation] = ORIENTATION[current_orientation_index + 1]
    else
      @position[:orientation] = ORIENTATION.first
    end
  end
  
  def increment_position(world)
    
    # Only move if our current orientation and position
    # are not marked as dangerous in the world
    
    unless world.robot_scent_array.include?(position)
      case @position[:orientation]
      when 'N'
        if @position[:y] == world.max_coordinates[:y]
          die_with_honor(world)
        else
          @position[:y] += 1
        end
      when 'E'
        if @position[:x] == world.max_coordinates[:x]
          die_with_honor(world)
        else
          @position[:x] += 1
        end
      when 'S'
        if @position[:y] == 0
          die_with_honor(world)
        else
          @position[:y] -= 1
        end
      when 'W'
        if @position[:x] == 0
          die_with_honor(world)
        else
          @position[:x] -= 1
        end
      else
      end
    end
  end
  
 # def sniff_for_danger(world)
#    world.robot_scent_array.each do |position|
#      if position == @position
#        return true
#    end
#    false
#  end
  
  def die_with_honor(world)
    # but leave a scent in the world
    world.push_to_robot_scent_array({:x => @position[:x], 
                                     :y => @position[:y], 
                                     :orientation => @position[:orientation]})
    @position[:lost] = true
  end

  def validate_position(position)
    if position[:orientation]
      position[:orientation].upcase!
    else
      return false
    end
    
    if position.is_a?(Hash) &&
       position[:x].is_a?(Integer) && 
       position[:y].is_a?(Integer) &&
       position[:orientation].is_a?(String) &&
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