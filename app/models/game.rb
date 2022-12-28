class Game < ApplicationRecord

  has_many :teams

  #a method for building a standings hash from game scores
  def build_standings()
    standings = {}
    self.games.each do |game|


    end
  end
end
