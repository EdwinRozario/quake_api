Rails.application.routes.draw do
	resources :games, only: [:index, :show] do
		get :details
		get :kill_modes
	end

	resources :kills, only: [:index, :show] do
		get :details
	end	
end
