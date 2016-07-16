Rails.application.routes.draw do
	resources :games, only: [:index, :show] do
		get :details
	end
end
