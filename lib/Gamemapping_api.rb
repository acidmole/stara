require 'nokogiri'
require 'open-uri'

# a class for retrieving games from Torneopal API and returning them as an array of hashes

class GamemappingApi

  #retrieves games from Torneopal API and returns them as an array of hashes
  def get_games_array_for(competition_id)
    key = Competition.find(competition_id).api_key
    uri = "https://koripallo-api.torneopal.fi/taso/widget.php?widget=schedule&#{key}"
    doc = Nokogiri::HTML(URI.open(uri), nil, 'UTF-8')
    cell_rows = doc.search('tr')
    sliced_rows = cell_rows.slice(2, cell_rows.size - 2)
    result_count = Competition.find(competition_id).results.count
    StandingsBuilder.new.build(competition_id) if build_game_array?(sliced_rows, competition_id) ||
      result_count != Competition.find(competition_id).results.count
  end

  # a method for building an array of hashes from a nokogiri NodeSet
  def build_game_array?(nset, competition_id)
    results_changed = false
    played = false
    score = nil
    i = 1
    while nset.size > 0
      element = nset.pop
      unless element.children[5].nil?
        if element.children[5].text != '–'
          score = element.children[5].text.split('–')
          played = true
        end
        date_text = element.children[0].text
        day, month, year = date_text.split('.').map(&:to_i)
        year += 2000
        date = Date.new(year, month, day)
        i += 1
        game = Game.find_or_create_by(
          game_day: date,
          game_time: element.children[1].text,
          home_team_id: Team.find_or_create_by(name: element.children[3].text).id,
          away_team_id: Team.find_or_create_by(name: element.children[4].text).id,
          played: played,
          competition_id: competition_id
        )
        if played
          result = Result.find_by(game_id: game.id)
          if result.nil?
            Result.create(
              game_id: game.id,
              home_team_score: score[0],
              away_team_score: score[1]
            )
            results_changed = true
          elsif result.home_team_score != score[0] || result.away_team_score != score[1]
          result.update(
            home_team_score: score[0],
            away_team_score: score[1]
          )
          results_changed = true
          end
        end
      end
    i += 1
    end
    results_changed
  end
end
