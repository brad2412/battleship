require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do 
  it 'can display a main menu' do
    game = Game.new
    expect(game.start).to eq("Welcome to BATTLESHIP 
    Enter p to play. Enter q to quit")
  end
end