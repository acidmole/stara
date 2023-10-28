require 'nokogiri'
require 'open-uri'

# a class for retrieving games from Torneopal API and returning them as an array of hashes

class GamemappingApi

  #retrieves games from Torneopal API and returns them as an array of hashes
  def get_games_array_for(key)
    uri = "https://koripallo-api.torneopal.fi/taso/widget.php?widget=schedule&#{key}"
    doc = Nokogiri::HTML(URI.open(uri), nil, 'UTF-8')
    cell_rows = doc.search('tr')
    sliced_rows = cell_rows.slice(2, cell_rows.size - 2)
    build_game_array(sliced_rows)
  end

  # a method for building an array of hashes from a nokogiri NodeSet
  def build_game_array(nset)
    return [] if nset.nil?
    game_array = []
    i = 0
    while nset.size > 0
      element = nset.pop
      unless element.children[5].nil? || element.children[5].text == '–'
        score = element.children[5].text.split('–')
        game_array[i] = {}
        date_text = element.children[0].text
        day, month, year = date_text.split('.').map(&:to_i)
        year += 2000
        date = Date.new(year, month, day)
        game_array[i][:date] = date
        game_array[i][:time] = element.children[1].text
        game_array[i][:home_team] = element.children[3].text
        game_array[i][:away_team] = element.children[4].text
        a = element.children[5].text
        game_array[i][:home_score] = score[0].to_i
        game_array[i][:away_score] = score[1].to_i
        i += 1
      end
    end
    game_array
  end
end
