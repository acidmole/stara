class GamesController < ApplicationController

  before_action :set_game, only: %i[ show edit update destroy ]

  # GET /games or /games.json
  def index
    @game_script = "<script src='https://koripallo-api.torneopal.fi/taso/widget.php?widget=schedule&competition=etekp2223&class=38733&group=300247&key=JPNVCZZSYU'></script>"
    @game_array = GamemappingApi.new.get_games_array_for("JPNVCZZSYU")
    check_for_new_games(@game_array)
    @games = Game.all
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
      params.require(:game).permit(:id, :gameday, :gametime, :hometeam, :awayteam)
    end

    def check_for_new_games(game_array)
      game_array.each do |game|
        if Game.find_by(game_day: game[:date], game_time: game[:time], home_team: game[:home_team], away_team: game[:away_team]).nil? 
          Game.create(game_day: game[:date], game_time: game[:time], home_team: game[:home_team], away_team: game[:away_team], home_score: game[:home_score], away_score: game[:away_score])
        end
      end
    end

end
