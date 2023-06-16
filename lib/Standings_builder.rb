class StandingsBuilder

def build_game_standings(competition_id)
    @games = Game.where(competition_id: competition_id)
    @standings = {}

    #initialize standings hash
    @games.each do |game|
        @standings[game.home_team_id] = {'competition': competition_id, 'team_id': game.home_team_id, 'games': 0, 'points': 0, 'wins': 0, 'losses': 0, 'scored_for': 0, 'scored_against': 0}
        @standings[game.away_team_id] = {'competition': competition_id, 'team_id': game.away_team_id, 'games': 0, 'points': 0, 'wins': 0, 'losses': 0, 'scored_for': 0, 'scored_against': 0}
    end
    #add points to standings hash
    @games.each do |game|
        if game.home_team_score > game.away_team_score
            @standings[game.home_team_id][:points] += 2
            @standings[game.home_team_id][:games] += 1
            @standings[game.home_team_id][:wins] += 1
            @standings[game.home_team_id][:scored_for] += game.home_team_score
            @standings[game.home_team_id][:scored_against] += game.away_team_score
            @standings[game.away_team_id][:games] += 1
            @standings[game.away_team_id][:losses] += 1
            @standings[game.away_team_id][:scored_for] += game.away_team_score
            @standings[game.away_team_id][:scored_against] += game.home_team_score
        else
            @standings[game.away_team_id][:points] += 2
            @standings[game.away_team_id][:games] += 1
            @standings[game.away_team_id][:wins] += 1
            @standings[game.away_team_id][:scored_for] += game.away_team_score
            @standings[game.away_team_id][:scored_against] += game.home_team_score
            @standings[game.home_team_id][:games] += 1
            @standings[game.home_team_id][:losses] += 1
            @standings[game.home_team_id][:scored_for] += game.home_team_score
            @standings[game.home_team_id][:scored_against] += game.away_team_score
        end
    end
    #update Standings table
    @standings.each do |team_id, team|
        if Standing.find_by(competition_id: competition_id, team_id: team_id).nil?
            Standing.create(team)
        else
            Standing.find_by(competition_id: competition_id, team_id: team_id).update(team)
        end
    end
end
end