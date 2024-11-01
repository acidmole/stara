class GamesController < ApplicationController

  helper_method :standings

  before_action :set_competition, only: [:index]


  # GET /games or /games.json
  def index
    GamemappingApi.new.get_games_array_for(@competition.id)
    @teams_with_standings = StandingsSorter.new.sort(@competition.id)
    @games_with_results = Competition.find(@competition.id).games.joins(:result).where(played: true)
  end



  private

  def set_game
    @game = Game.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def game_params
    params.require(:competition).permit(:id, :name)
  end

  def standings
    @standings = Standing.where(competition_id: competition_id)
  end

  def set_competition
    if params[:competition_id].present?
      @competition = Competition.find(params[:competition_id])
    else
      @competition = Competition.active.first
    end
  end
end
