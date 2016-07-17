class Game < ApplicationRecord
	has_many :players # should have created a through relation for this.
	has_many :kills
end
