require_relative "player.rb"
require_relative "gameview.rb"
require_relative "board.rb"

class Game

  attr_accessor :type

  def initialize
    @board = Board.new
    @players = []
    @playera = Player.new
    @playerb = Player.new
    @type = nil
    @view = GameView
    @most_recent__move = nil
  end

  def start_game
    @view.welcome_message
    set_up_game
    play_game
  end

  def set_up_game
    establish_game_type
    enter_player_names
    select_markers
    determine_game_order
  end

  def enter_player_names
    @playera.set_name
    @playerb.set_name
  end

  def select_markers
    @playera.set_marker
    @playerb.set_marker
  end

  def establish_game_type
    set_game_type
    set_player_types
  end

  def set_game_type
    until @type
      @view.select_game_type_message
      input = gets.chomp
      if input == '1'
        @type = "human vs computer"
        @view.game_type_message(@type)
      elsif input == '2'
        @type = "human vs human"
        @view.game_type_message(@type)
      elsif input == '3'
        @type = "computer vs computer"
        @view.game_type_message(@type)
      else
        @view.invalid_game_type_message
      end
    end
  end

  def set_player_types
    if @type == "human vs computer"
      @playera.type = "human"
      @playerb.type = "computer"
    elsif @type == "human vs human"
      @playera.type = "human"
      @playerb.type = "human"
    else
      @playera.type = "computer"
      @playerb.type = "computer"
    end
  end

  def determine_game_order
    while true
      @view.who_plays_first_message(@playera.name,@playerb.name)
      order_preference = gets.chomp
      break if order_preference == "1" || order_preference == "2"
      @view.invalid_first_player_message
    end
    if order_preference == '1'
      @players = [@playera,@playerb]
    else
      @players = [@playerb,@playera]
    end
  end

  def play_game
    until @board.game_is_over? || @board.tie?
      play_round
    end
    evaluate_game_result
  end

  def play_round
    round_visuals
    move = @players.first.get_move(@board)
    @most_recent_move = ({name:@players.first.name,spot:move})
    @board.mark_space({spot_number:move,player_marker: @players.first.marker})
    @players.reverse!
  end

  def round_visuals
    @view.clear_screen
    @view.display_board(@board.spaces)
    if @most_recent_move
      @view.recent_move_message(@most_recent_move)
    end
    if @type == "computer vs computer"
      @view.dot_dot_dot
    end
  end

  def evaluate_game_result
    @view.clear_screen
    if @board.won_game?(@playera.marker)
      @view.won_game(@playera.name)
    elsif @board.won_game?(@playerb.marker)
      @view.won_game(@playerb.name)
    else
      @view.tie_game
    end
    @view.display_board(@board.spaces)
  end

end

