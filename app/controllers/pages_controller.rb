class PagesController < ApplicationController

  def home
    @board = Board.first
    @board_data = @board.data['categories']
  end

end
