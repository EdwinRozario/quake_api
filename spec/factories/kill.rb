FactoryGirl.define do
  factory :kill do
  	# method 'MOD_ROCKET' # seems like method is a reserver word
  	game
  	association :killer, factory: :player
  	association :victim, factory: :player
  end
end