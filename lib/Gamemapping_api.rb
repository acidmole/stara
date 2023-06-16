require 'nokogiri'
require 'open-uri'

# a class for retrieving games from Torneopal API and returning them as an array of hashes

class GamemappingApi

  #retrieves games from Torneopal API and returns them as an array of hashes
  def get_games_array_for(key)
    uri = "https://koripallo-api.torneopal.fi/taso/widget.php?widget=schedule&#{key}"
    doc = Nokogiri::HTML(URI.open(uri))
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
      if !element.children[5].nil?
        game_array[i] = {}
        game_array[i][:date] = element.children[0].text
        game_array[i][:time] = element.children[1].text
        game_array[i][:home_team] = element.children[3].text
        game_array[i][:away_team] = element.children[4].text
        a = element.children[5].text
        game_array[i][:home_score] = a.slice!(0,2)
        a.slice!(0,3)
        game_array[i][:away_score] = a
        i += 1
      end
    end
    game_array
  end
  

  def game_data
    url = "https://tulospalvelu.basket.fi/category/38733!etekp2223/results"
    doc = Nokogiri::HTML(URI.open(uri))
    text = doc.text
    puts text
  end
end
