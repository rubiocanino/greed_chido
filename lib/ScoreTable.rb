require  'colorize'

class ScoreTable
  @@line = '|||||||||||||||||||||||||||||||||||'.colorize(:light_blue)

  #To display the name of the player and their points
  def displayPoints(listPlayer)
    system('clear')
    puts '||||||||||| P O I N T S |||||||||||'.colorize(:light_blue)
    listPlayer.each  do |player|
      print "\t      #{player.name}\t | "
      puts "#{player.score}".colorize(:green)
    end
    puts @@line
  end

  #To display all the players
  def displayListPlayer(listPlayer)
    system('clear')
    puts '|||||||||| P L A Y E R S ||||||||||'.colorize(:light_blue)
    listPlayer.each  { |player| puts "\t      #{player.name}" }
    puts @@line
  end

  #To check if the name is available
  def checkName(listPlayer,newPlayer)
    checkName = []
    checkName = listPlayer.map {|player| player.name == newPlayer}
    if checkName.include?(true) and newPlayer != nil
      puts  'This name it\'s already took it.'.colorize(:red)
      return false
    else
      return true
    end
  end

  #To control the workflow of getting the score and actualize the values of the dice
  def evaluate(listPlayer,player)
   matches = countMatches(listPlayer[player].arrayV)
   arrayOfValues = getPoints(matches,listPlayer[player].arrayV)
   return arrayOfValues
  end

  #To count the matches of each value of the array of values
  def countMatches (valuesDice)
    matches = []
     matches <<  valuesDice.count(1)
     matches <<  valuesDice.count(2)
     matches <<  valuesDice.count(3)
     matches <<  valuesDice.count(4)
     matches <<  valuesDice.count(5)
     matches <<  valuesDice.count(6)
     return matches
  end

  #To get the score of the array of values and return the actualize array with the score
  def getPoints(matches,valuesDice)
    score = 0
    matches.each_with_index do |number,index|
      case index
        when 0
          score = 1000 if number >= 3
          valuesDice = actualize(3,1,valuesDice) if number >= 3
          puts  "Three 1's => 1000 points".colorize(:blue) if number >=3
          score += 100 if number == 1
          puts " One   1   =>  100 points".colorize(:blue) if number == 1
          valuesDice = actualize(1,1,valuesDice) if number == 1
        when 1
          score += 200 if number >= 3
          valuesDice = actualize(3,2,valuesDice) if number >= 3
          puts " Three 2's =>  200 points".colorize(:blue) if number >=3
        when 2
          score += 300 if number >= 3
          valuesDice = actualize(3,3,valuesDice) if number >= 3
          puts " Three 3's =>  300 points".colorize(:blue) if number >=3
        when 3
          score += 400 if number >= 3
          valuesDice = actualize(3,4,valuesDice) if number >= 3
          puts "  Three 4's =>  400 points".colorize(:blue) if number >=3
        when 4
          score += 500 if number >= 3
          valuesDice = actualize(3,5,valuesDice) if number >= 3
          puts " Three 5's =>  500 points".colorize(:blue) if number >=3
          score += 50 if number == 1
          valuesDice = actualize(1,5,valuesDice) if number == 1
          puts " One   5   =>   50 points".colorize(:blue) if number == 1
        when 5
          score += 600 if number >= 3
          valuesDice = actualize(3,6,valuesDice) if number >= 3
          puts " Three 6's =>  600 points".colorize(:blue) if number >=3
      end
    end
    valuesDice << score
    return valuesDice
  end

  #To delete the dices that make points and return just the once that doesn't
  def actualize(timesToDelete,value,valuesDice)
    timesToDelete.times { valuesDice.delete_at(valuesDice.index(value)) }
    return valuesDice
  end

  #To verify if in the game exist a winners
  def winner (listPlayers)
    winner = -1
    listPlayers.each_with_index do |player,index|
      winner = index if player.score >= 1500
      break if winner >= 0
    end
    return winner
  end

  #To celebrate the winner of the game
  def celebrate (winner,listOfPlayers)
    system('clear')
    3.times { puts "========= C O N G R A T U L A T I O N S =========".colorize(:green) }
    puts "------------------>   #{listOfPlayers[ winner ].name}   <------------------".upcase.colorize(:red)
    puts "================ You deserve it! ================".colorize(:green)
    gets.chomp
  end

  #To display who is gonna roll
  def displayTurn(listPlayer,player)
    self.displayPoints( listPlayer )
    2.times { puts "\n"}
    print "--> Your turn "
    puts " #{listPlayer[player].name}".colorize(:green)
    puts "Roll the dices! "
    print "Press "
    print "enter ".colorize(:red)
    print "to roll: "
    gets.chomp
  end
end
