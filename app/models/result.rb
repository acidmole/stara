# frozen_string_literal: true

class Result < ActiveRecord::Base
  belongs_to :game, dependent: :destroy
  validates :game_id, uniqueness: true
  validates :home_team_score, presence: true
  validates :away_team_score, presence: true
end