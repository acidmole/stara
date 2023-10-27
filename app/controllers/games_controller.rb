class GamesController < ApplicationController

  helper_method :standing

  before_action :set_competition_id


  # GET /games or /games.json
  def index
    if params[:competition_id].present?
      @competition_id = params[:competition_id]
    else
      @competition_id = Competition.first.id
    end
    @games = GamemappingApi.new.get_games_array_for(Competition.find(@competition_id).api_key)
    if @games.present?
      if check_for_new_games(@games, @competition_id)
        StandingsBuilder.new.build(@competition_id)
      end
    end
    @teams_with_standings = StandingsSorter.new.sort(@competition_id)
    @competition = Competition.find(@competition_id)
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:competition).permit(:id, :name)
    end

    def check_for_new_games(game_array, competition_id)
      updated = false
      game_array.each do |game|
        home_team = Team.find_or_create_by(name: game[:home_team])
        away_team = Team.find_or_create_by(name: game[:away_team])
        searched_game = Game.find_by(game_day: game[:date],
                     game_time: game[:time],
                     home_team_id: home_team.id,
                     away_team_id: away_team.id,
                     home_team_score: game[:home_score],
                     away_team_score: game[:away_score],
                     competition_id: competition_id)
        if searched_game.nil?
          Game.create(game_day: game[:date],
                      game_time: game[:time],
                      home_team_id: home_team.id,
                      away_team_id: away_team.id,
                      home_team_score: game[:home_score],
                      away_team_score: game[:away_score],
                      competition_id: competition_id)
          updated = true
        end
      end
      if Standing.where(competition_id: competition_id).empty?
        updated = true
      end
      updated
    end

  def standings
    @standings = Standing.where(competition_id: competition_id)
  end

  public def set_competition_id
    @competition_id = params[:competition_id] || Competition.first.id
  end
end
