class Game < ApplicationRecord
	has_many :game_players
	has_many :kills

	has_many :players, through: :game_players

	def real_players
		self.players.where.not(name: '<world>')
	end
end
