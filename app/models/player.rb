class Player < ApplicationRecord
	belongs_to :game

	has_many :kills, :class_name => 'Kill', :foreign_key => 'killer_id'
	has_many :deaths, :class_name => 'Kill', :foreign_key => 'victim_id'
end
