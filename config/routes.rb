Rails.application.routes.draw do
  resources :standings
  resources :games, only: [:index, :show]
  resources :competitions, only: [:index, :show]
  
  root 'games#index'
  post 'games/competition', to: 'games#competition'

  resource :rosters, only: [:show]

end
