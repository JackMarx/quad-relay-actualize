Rails.application.routes.draw do
  get '/' => 'enterences#guest'
  get '/open_door', to: 'enterences#open_both', as: 'enterences'
  post '/login', to: 'sessions#create', as: 'login'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
end
