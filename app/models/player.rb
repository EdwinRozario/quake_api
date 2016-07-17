class Player < ApplicationRecord
  has_many :game_players

  has_many :kills, :class_name => 'Kill', :foreign_key => 'killer_id'
  has_many :deaths, :class_name => 'Kill', :foreign_key => 'victim_id'

  has_many :games, through: :game_players
end
