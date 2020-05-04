Rails.application.routes.draw do
  resources :artists
  

  resources :artists, only: [:show] do 
    # nested resource for songs
    resources :songs, only: [:index, :show]
  end

  resources :songs

  root 'songs#index'
end
