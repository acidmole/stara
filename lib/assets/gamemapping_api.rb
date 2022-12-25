class GamemappingApi

#this class fetches games for the selected key

def sel.get_games_for(key)
  url = "https://koripallo-api.torneopal.fi/taso/widget.php?widget=schedule&competition=etekp2223&class=38733&group=300247&key=#{key}"
  response = HTTParty.get "#{url}"
  games = response.parsed_response