class GamesController < ApplicationController

  before_action :set_game, only: %i[ show edit update destroy ]

  # GET /games or /games.json
  def index
    
    if params[:competition_id].nil?
      competition_id = Competition.first.id
    else
      competition_id = params[:competition_id]
    end
    @game_script = "<script src='https://koripallo-api.torneopal.fi/taso/widget.php?widget=schedule&competition=etekp2223&class=38733&group=300247&key=JPNVCZZSYU'></script>"
    @game_array = GamemappingApi.new.get_games_array_for(Competition.find(competition_id).api_key)
    check_for_new_games(@game_array, competition_id) unless @game_array.nil?
    @games = @game_array
    @standings = StandingsBuilder.new.build_game_standings(Competition.find(competition_id))

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

      game_array.each do |game|
        home_team = Team.find_by(name: game[:home_team])
        away_team = Team.find_by(name: game[:away_team])
        if home_team.nil? || away_team.nil? || Game.find_by(game_day: game[:date], game_time: game[:time], home_team_id: home_team.id, away_team_id: away_team.id, competition_id: competition_id).nil?
          if Team.find_by(name: game[:home_team]).nil?
            home_team = Team.create(name: game[:home_team])
          end
          if Team.find_by(name: game[:away_team]).nil?
            away_team = Team.create(name: game[:away_team])
          end
          Game.create(game_day: game[:date], game_time: game[:time], home_team_id: home_team.id, away_team_id: away_team.id, home_team_score: game[:home_score], away_team_score: game[:away_score], competition_id: competition_id)
        end
      end
    end



end
