require "greed_chido/version"
require 'colorize'
require 'Help'
require 'Player'
require 'ScoreTable'
require 'Board'

module GreedChido
  class Greed
    def initialize
      game = Board.new.menu
    end
  end
end
