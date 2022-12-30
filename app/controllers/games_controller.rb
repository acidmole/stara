require 'games_helper'

class GamesController < ApplicationController

  before_action :set_game, only: %i[ show edit update destroy ]

  # GET /games or /games.json
  def index
    @game_script = "<script src='https://koripallo-api.torneopal.fi/taso/widget.php?widget=schedule&competition=etekp2223&class=38733&group=300247&key=JPNVCZZSYU'></script>"
    @game_array = GamemappingApi.new.get_games_array_for("JPNVCZZSYU")
    check_for_new_games(@game_array, Competition.first)
    @games = @game_array
    @competitions = Competition.all
    @standings = helpers.build_game_standings(@competitions.first)
  end

  # GET /games/1 or /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to game_url(@game), notice: "Game was successfully created." }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to game_url(@game), notice: "Game was successfully updated." }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
      format.json { head :no_content }
    end
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

    def check_for_new_games(game_array, competition)

      game_array.each do |game|
        home_team = Team.find_by(name: game[:home_team])
        away_team = Team.find_by(name: game[:away_team])
        if home_team.nil? || away_team.nil? || Game.find_by(game_day: game[:date], game_time: game[:time], home_team_id: home_team.id, away_team_id: away_team.id, competition_id: competition).nil?
          if Team.find_by(name: game[:home_team]).nil?
            home_team = Team.create(name: game[:home_team])
          end
          if Team.find_by(name: game[:away_team]).nil?
            away_team = Team.create(name: game[:away_team])
          end
          Game.create(game_day: game[:date], game_time: game[:time], home_team_id: home_team.id, away_team_id: away_team.id, home_team_score: game[:home_score], away_team_score: game[:away_score], competition_id: competition.id)
        end
      end
    end



end
