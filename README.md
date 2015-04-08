# tictactoe

I'd like to explain my algorithm for determining the winning patterns.
First I created a method times_in_slot which accepts a 2 parameters (slot, letter) and by iterating over the entire board, enables me to count the spots each player has taken.

Next I have a check_board method which has a game_over variable set to nil.
I access @win_combos (which I have in my initialize method and also set in my attr_accessor) and begin to iterate through it. If times_in_slot is equal to 3 for either player (i.e. it matches a @win_combo) that player wins. Otherwise it’s a tie game.  
