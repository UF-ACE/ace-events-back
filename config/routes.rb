Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  

  post '/auth/developer/callback', to: 'sessions#create', defaults: { format: :json }
  get '/logout', to: 'sessions#destroy', defaults: { format: :json }
end
