require 'Player'
require 'ScoreTable'
require 'Help'
require 'colorize'

class Board
  @@listPlayer = []
  @@scoreTable = ScoreTable.new
  @@support =  Help.new

  public
  def initialize
    'Write game.menu to start the game'
  end

  #To control the start of the game and the ending
  def menu()
    system('clear')
    puts  '==================== M E N U ===================='.colorize(:light_blue)
    puts  "              Press enter to start".colorize(:green)
    gets.chomp
    @@support.help
    numberPlayers
    sleep (0)
    game
    return "Finishing the game"
  end

  public

  #To get started with the players and their profiles
  def numberPlayers
    list = []
    system('clear')
    numberPlayer = validNumberPlayer
    3.times {puts "\n"}
    i = 1
    numberPlayer.times do |player|
      player = capturePlayer(i)
        @@listPlayer << player
      i+=1
    end
    @@scoreTable.displayListPlayer(@@listPlayer)
    return "Validation of players"
  end

  #To validate the number of player that will play
  def validNumberPlayer
    numberPlayer = 0
    loop do
      print "How many players? | "
      numberPlayer = gets.chomp.to_i
      @@support.help if numberPlayer == 0
      return numberPlayer if numberPlayer != nil and numberPlayer > 1
    end
  end

  #To capture the name of the player
  def capturePlayer(numberOfPlayer)
    loop do
      player =  Player.new
      puts '---------------------------'
      print "Name of player ##{numberOfPlayer} : ".colorize(:green)
      player.name = gets.chomp.capitalize
      player.score = 0
      player.arrayV = []
      return player if player.name != nil and @@scoreTable.checkName(@@listPlayer,player.name)
    end
  end

  #To control all the flow of the game
  def game
    player = 0
    dices = 5
    winner = -1
    @@scoreTable.displayPoints( @@listPlayer )
    loop do
      dices.times{ @@listPlayer[ player ].arrayV << rollDice }
      @@listPlayer[ player ].arrayV.sort!
      @@scoreTable.displayTurn(@@listPlayer, player)
      dices = updatePlayer( player )
      player+=1 if dices == 0
      dices = 5 if dices == 0
      player = 0 if player >= @@listPlayer.length
      winner = @@scoreTable.winner(@@listPlayer)
      break if winner >= 0
      2.times { puts "\n " }
    end
    @@scoreTable.celebrate(winner,@@listPlayer)
    system('clear')
    puts "~~~~~~~~~~~~~~~~ Thanks for playing ~~~~~~~~~~~~~~~~~"
    puts "~~~~~~~~~~~~~ Gem created by rubiocanino ~~~~~~~~~~~~~"
    puts ""
  end

  #To update the values of the array of values get it from rolling the dices
  def updatePlayer(player)
    puts "\n"
    print "#{ frase } | "
    print " #{@@listPlayer[player].name }".colorize(:green)
    print " you roll : "
    valuesOfRoll = @@listPlayer[player].arrayV
    p valuesOfRoll
    arrayValuesPoints = @@scoreTable.evaluate(@@listPlayer, player)
    scoreRolling = arrayValuesPoints.pop
    print "You got : "
    print "#{scoreRolling}".colorize(:green) if scoreRolling > 0
    print "#{scoreRolling}".colorize(:red) if scoreRolling == 0
    print " points "
    gets.chomp
    @@listPlayer[ player ].score += scoreRolling
    dices = arrayValuesPoints.length
    @@listPlayer[ player ].arrayV = []
    dices = 0  if scoreRolling == 0
    @@listPlayer[ player ].score = 0 if @@listPlayer[ player ].score < 300 and dices == 0
    return dices
  end

  #To got the value of rolling a dice
  def rollDice
    value = 1
    loop do
      value = (rand * 6.5).to_i
      break if value >0
    end
    return value
  end

  #To change the quote of the play
  def frase
    option = 0
    loop do
      option = (rand * 5.5).to_i
      break if option > 0
    end
    case option
    when 1
      return "Amazing! "
    when 2
      return "Good roll! "
    when 3
      return "Incredible! "
    when 4
      return "Good movement! "
    when 5
      return "Are you cheating? "
    end
  end

end
