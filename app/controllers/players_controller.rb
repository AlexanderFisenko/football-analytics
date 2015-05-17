class PlayersController < ApplicationController

  def show
    @player = Player.find(params[:id])
    
    respond_to do |format|
      format.json { render json: @player, root: false }
    end
  end

  def incoming
    ParsingWorker.perform_async(params[:xml])

    render text: 'Parsing completed!'
  end

end
