require 'nokogiri'
require 'open-uri'

# a class for retrieving games from Torneopal API and returning them as an array of hashes

class GamemappingApi

  #retrieves games from Torneopal API and returns them as an array of hashes
  def get_games_array_for(competition_id)
    key = Competition.find(competition_id).api_key
    uri = "https://koripallo-api.torneopal.fi/taso/widget.php?widget=schedule&#{key}"
    doc = Nokogiri::HTML(URI.open(uri), nil, 'UTF-8')
    game_rows = doc.css('tr[class^="team_"]')
    result_count = Competition.find(competition_id).results.count
    StandingsBuilder.new.build(competition_id) if build_game_array?(game_rows, competition_id) ||
      result_count != Competition.find(competition_id).results.count
  end

  # a method for building an array of hashes from a nokogiri NodeSet
  def build_game_array?(game_rows, competition_id)
    new_games = false
    game_rows.each do |row|
      date = row.css('td.date').text.strip
      date = date.split('.').reverse.join('-')
      date = Date.parse(date)
      next if date > Date.today
      match_id = row['class'][/matchid_(\d+)/, 1]
      result = Result.find_by(game_id: match_id)
      next if result.present?
      new_games = true
      team_ids = row['class'].scan(/team_(\d+)/).flatten.uniq
      home_team = Team.find_or_create_by(id: team_ids[0], name: row.css('td.home').first.text.strip)
      away_team = Team.find_or_create_by(id: team_ids[1], name: row.css('td.away').last.text.strip)
      time = row.css('td.time').text.strip
      date_time = "#{date} #{time}"
      score_cell = row.css('td.score').text.strip
      score = score_cell.split('–').map(&:to_i)
      Game.create!(competition_id: competition_id, home_team_id: home_team.id, away_team_id: away_team.id, game_datetime: date_time, id: match_id, played: true)
      Result.create!(game_id: match_id, home_team_score: score[0], away_team_score: score[1])
    end
    new_games
  end
end
