Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  

  post '/auth/developer/callback', to: 'sessions#create'
  post '/auth/ace_cloud/callback', to: 'sessions#create'
  get '/auth/logout', to: 'sessions#destroy'
end
