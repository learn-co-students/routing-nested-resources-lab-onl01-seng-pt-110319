Rails.application.routes.draw do
  resources :artists, only: [:index, :show] do 
    resources :songs, only: [:index, :show]
  end

  resources :songs
end
