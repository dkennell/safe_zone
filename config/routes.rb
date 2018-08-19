Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  get '/locations/:id', to: 'locations#show'
  get '/info', to: 'home#info'
  get '/how-to-help', to: 'home#how_to_help'
  get '/locations/:id/polygons', to: 'locations#polygons'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
