module GamesHelper

    def check_for_unlisted_games(game_array)
        game_array.each do |game|
            if Game.find_by(date: game[:date], time: game[:time], home_team: game[:home_team], away_team: game[:away_team], home_score: game[:home_score], away_score: game[:away_score]).nil?
                Game.create(date: game[:date], time: game[:time], home_team: game[:home_team], away_team: game[:away_team], home_score: game[:home_score], away_score: game[:away_score])
            end
        end
    end
end
