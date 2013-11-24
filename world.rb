class World  
  def initialize(dimensions)
    @@max_coordinates = nil
    @@max_x = 50
    @@max_y = 50
    
    # For storing dangerous places where previous robots
    # were lost forever
    @@robot_scent_positions = []
    
    set_max_coordinates(dimensions)
  end
  
  def set_max_coordinates(dimensions)
    if validate_max_coordinates(dimensions)
      @@max_coordinates = dimensions
    end
  end
  
  def max_coordinates
    @@max_coordinates
  end
  
  def robot_scent_array
    @@robot_scent_positions
  end
  
  # Used by robots wandering off the world edges
  def push_to_robot_scent_array(position)
    @@robot_scent_positions << position
  end
  
private
  def validate_max_coordinates(coordinates)
    if coordinates.is_a?(Hash) &&
       coordinates[:x].is_a?(Integer) && 
       coordinates[:y].is_a?(Integer) 
        coordinates[:x] < @@max_x && coordinates[:x] > 0 &&
        coordinates[:y] < @@max_y && coordinates[:y] > 0
    else
      false
    end
  end
end