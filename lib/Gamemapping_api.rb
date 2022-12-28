require 'nokogiri'
require 'open-uri'

class GamemappingApi
  
  def get_games_hash_for(key)
    uri = "https://koripallo-api.torneopal.fi/taso/widget.php?widget=schedule&competition=etekp2223&class=38733&group=300247&key=#{key}"
    doc = Nokogiri::HTML(URI.open(uri))
    cell_rows = doc.search('tr')
    sliced_rows = cell_rows.slice(2, cell_rows.size - 2)
    build_game_array(sliced_rows)
  end

  # a method for building an array of hashes from a nokogiri node set
  def build_game_array(nset)
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
  
end
