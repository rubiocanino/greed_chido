class Help
  def initialize; end
  @@line = "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

  #To control all the options to bring help to the player
  def help
    check  = false
    loop do
      system('clear')
      puts "Rules of the game"
      puts @@line.colorize(:light_blue)
      puts "1) How many player can be? "
      puts "2) How can I do make points? "
      puts "3) Example of making points. "
      puts "4) How many points do I need to win? "
      puts "5) Exit or just enter to START the game.  ".colorize(:red)
      puts @@line.colorize(:light_blue)
      print "Option: "
      answer = gets.chomp.to_i
      case answer
      when 0
        check = true
      when 1
        space
        help_players
      when 2
        space
        help_HowToDoPoints
      when 3
        space
        help_ExamplePoints
      when 4
        space
        help_HowManyPoints
      when 5
        check = true
      else
        print "Sorry I don't know."
        system('clear')
      end
      break if check
    end
    system('clear')
  end

  #To put space between the menu and the option that was selectionated
  def space
    3.times { puts "\n"}
  end

  #To display the confirmation
  def pressToContinue
    puts "\n"
    print "Press enter to continue. "
    gets.chomp
  end

  #To display how many player can play
  def help_players
    puts "Greed is a dice game played among 2 or more players, using 5"
    puts  "six-sided dice."
    pressToContinue
  end

  #To display the options of how can you do Points
  def help_HowToDoPoints
    puts  "Each player takes a turn consisting of one or more rolls of the dice."
    puts  "On the first roll of the game, a player rolls all five dice which are"
    puts  "scored according to the following:"
    puts  "\n"
    puts  "\tThree 1's => 1000 points"
    puts  "\tThree 6's =>  600 points"
    puts  "\tThree 5's =>  500 points"
    puts  "\tThree 4's =>  400 points"
    puts  "\tThree 3's =>  300 points"
    puts  "\tThree 2's =>  200 points"
    puts  "\tOne   1   =>  100 points"
    puts  "\tOne   5   =>   50 points"
    pressToContinue
  end

  #To display an example of how works the make points
  def help_ExamplePoints
    puts " Throw       Score"
    puts "---------   ------------------"
    puts "5 1 3 4 1   50 + 2 * 100 = 250"
    puts "1 1 1 3 1   1000 + 100 = 1100"
    puts "2 4 4 5 4   400 + 50 = 450"
    pressToContinue
  end

  #To display how many points do you need for win
  def help_HowManyPoints
    puts " You need to have 1500 or more points to win the game."
    pressToContinue
  end
end
