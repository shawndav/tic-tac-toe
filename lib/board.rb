class Board

  attr_accessor :spaces

def initialize
  @spaces = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
  @orig_spaces = @spaces.dup
end

def available_spaces
  @spaces.dup.delete_if{|space| !@orig_spaces.include?(space)}
end

def spaces_left
  self.available_spaces.length
end

def center
  @spaces[4]
end

def corners
  [@spaces[0],@spaces[2],@spaces[6],@spaces[8]]
end

def sides
  [@spaces[1],@spaces[3],@spaces[5],@spaces[7]]
end

def return_random_corner
  available_spaces.select{|space| space.to_i % 2 == 0 && space.to_i != 4}.sample
end

def return_random_space
  available_spaces.sample
end

def mark_space(input_hash)
  @spaces[input_hash[:spot_number].to_i] = input_hash[:player_marker]
end

def game_is_over?
  [@spaces[0], @spaces[1], @spaces[2]].uniq.length == 1 ||
  [@spaces[3], @spaces[4], @spaces[5]].uniq.length == 1 ||
  [@spaces[6], @spaces[7], @spaces[8]].uniq.length == 1 ||
  [@spaces[0], @spaces[3], @spaces[6]].uniq.length == 1 ||
  [@spaces[1], @spaces[4], @spaces[7]].uniq.length == 1 ||
  [@spaces[2], @spaces[5], @spaces[8]].uniq.length == 1 ||
  [@spaces[0], @spaces[4], @spaces[8]].uniq.length == 1 ||
  [@spaces[2], @spaces[4], @spaces[6]].uniq.length == 1
end

def won_game?(player_marker)
  [@spaces[0], @spaces[1], @spaces[2]].uniq == [player_marker] ||
  [@spaces[3], @spaces[4], @spaces[5]].uniq == [player_marker] ||
  [@spaces[6], @spaces[7], @spaces[8]].uniq == [player_marker] ||
  [@spaces[0], @spaces[3], @spaces[6]].uniq == [player_marker] ||
  [@spaces[1], @spaces[4], @spaces[7]].uniq == [player_marker] ||
  [@spaces[2], @spaces[5], @spaces[8]].uniq == [player_marker] ||
  [@spaces[0], @spaces[4], @spaces[8]].uniq == [player_marker] ||
  [@spaces[2], @spaces[4], @spaces[6]].uniq == [player_marker]
end

def tie?
  @spaces.all? { |space| !@orig_spaces.include?(space) }
end

def winning_move?(input_hash)
  winning = false
  spot = input_hash[:spot_number]
  marker = input_hash[:player_marker]
  @spaces[spot.to_i] = marker
  if game_is_over?
    winning = true
  end
  @spaces[spot.to_i] = spot.to_s
  return winning
end

end


