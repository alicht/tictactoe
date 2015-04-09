class TicTacToe
  
  attr_accessor :slots, :win_combos
  
  def initialize(play_game = false)
    @slots = {
      "a1"=>" ", "a2"=>" ", "a3"=>" ",
      "b1"=>" ", "b2"=>" ", "b3"=>" ",
      "c1"=>" ", "c2"=>" ", "c3"=>" ", 
    }
    
    @win_combos = [
      ['a1', 'a2', 'a3'],
      ['b1', 'b2', 'b3'],
      ['c1', 'c2', 'c3'],
      
      ['a1', 'b1', 'c1'],
      ['a2', 'b2', 'c2'],
      ['a3', 'b3', 'c3'],
      
      ['a1', 'b2', 'c3'],
      ['c1', 'b2', 'a3']
    ]
    
    @player1 = 'X'
    @player2 = 'O'
    if play_game
      greeting
      pick_symbol
      user_move
      computer_move
    end 
  end

  def pick_symbol
    puts "Select to be X or O"
    @player1= gets.chomp.capitalize
    if @player1 != 'X' && @player1 != 'O'
      puts "incorrect symbol"
      pick_symbol
    else
      if @player1 == 'O'
        @player2 = 'X'
      end
    end
  end
  
  def greeting
    puts ""
    @computer = "Trey Anastasio"
    puts "Hello, my name is #{@computer} and welcome to Tic-Tac-Toe!"
    puts ""
    puts "Before we get started, what is your name?"
    @user_name = gets.chomp.capitalize
    puts '------------------------------------------------------------------'
    puts "Nice to meet you #{@user_name}!"
    instructions
  end
  
  def instructions
    puts "#{@user_name} will be '#{@player1}' and #{@computer} will be '#{@player2}'"
    puts '------------------------------------------------------------------'
    puts "Directions: make a move by entering the letter & number representing
       the slot youre trying to fill. For example, 'a1' , 'b2', 'c3', etc."
  end
  
  def show_board
    puts '------------------------------------------------------------------'
    puts "   a b c"
    puts ' '
    puts " 1 #{@slots["a1"]}|#{@slots["b1"]}|#{@slots["c1"]}"
    puts '   ------'
    puts " 2 #{@slots["a2"]}|#{@slots["b2"]}|#{@slots["c2"]}"
    puts '   ------'
    puts " 3 #{@slots["a3"]}|#{@slots["b3"]}|#{@slots["c3"]}"
    puts '------------------------------------------------------------------'
  end
  
  def user_move
   show_board
   puts "#{@user_name} please make your move."
   move = gets.chomp.downcase
    
    return wrong_input unless move.length == 2 
      x = move.split("")
      if(['a','b','c'].include? x[0])
        if(['1','2','3'].include? x[1])
          if @slots[move] == " "
            @slots[move] = @player1
            puts "#{@user_name} has selected #{move}"
          else
            wrong_move
          end
        else
          wrong_input
        end
      else
        wrong_input
      end
    show_board
    computer_move
  end
  
  def wrong_input
    puts "Please specify a move using the format 'a1' , 'b2' , 'c3' etc."
    user_move
  end
  
  def wrong_move
    puts "Whoops! That spot is already filled- please choose another!"
    user_move
  end

  def moves_remaining
    slots = 0
    @slots.each do |key, value|
      slots += 1 if value == " "
    end
    slots
  end

  def computer_move
      move = find_move
      @slots[move] = @player2
      puts "#{@computer} selects #{move}"
      check_board(@player1)
  end
  
  
  def find_move
    @win_combos.each do |option|
      if times_in_slot(option, @player2) == 2
        return empty_slot option
      end
    end
    
    @win_combos.each do |option|
      if times_in_slot(option, @player1) == 2
        return empty_slot option
      end
    end
    
    @win_combos.each do |option|
      if times_in_slot(option, @player2) == 1
        return empty_slot option
      end
    end
    
    random_move
  end
  
  def random_move
    key = @slots.keys;
    move = rand(key.length)
    if @slots[key[move]] == " "
      return key[move]
    else
      @slots.each { |key,value| return key if value == " "}
    end
  end

  def times_in_slot(slot, letter)
    times = 0
    slot.each do |x|
      times += 1 if @slots[x] == letter
      unless @slots[x] == letter || @slots[x] == " "
        return 0
      end
    end
    times
  end
  
  def empty_slot(slot)
    slot.each do |x|
      if @slots[x] == " "
        return x
      end
    end
  end

  def is_game_over?
    puts "Play Again?"
    answer = gets.chomp.downcase

    if answer == 'y'
      @slots = {
        "a1"=>" ", "a2"=>" ", "a3"=>" ",
        "b1"=>" ", "b2"=>" ", "b3"=>" ",
        "c1"=>" ", "c2"=>" ", "c3"=>" ", 
      } 
      false
    else
      true
    end
  end
    
  def check_board(next_move)
    
    game_over = nil
    
    @win_combos.each do |slot|
      # check to see if computer has won
      if times_in_slot(slot, @player2) == 3
        puts "GAME OVER... #{@computer} wins!"
        game_over = is_game_over?
        show_board
      end
      
      # check to see if user has won
      if times_in_slot(slot, @player1) == 3
        puts "GAME OVER... #{@user_name} wins!"
        game_over = is_game_over?
        show_board
        
      end
    end
    
    unless game_over
      if(moves_remaining > 0)
        if(next_move == @player1)
          user_move
        else
          computer_move
        end
      else
        puts "Tie game, try again!"
        unless is_game_over?
          user_move
        else
         puts "THE GAME IS OVER!"
         show_board
         abort
        end

      end
     else 
      puts "THE GAME IS OVER!"
      show_board
      abort
    end
  end  
  
end

TicTacToe.new(true)