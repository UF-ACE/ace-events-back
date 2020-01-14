Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  post '/auth/developer/callback', to: 'sessions#create'
  post '/auth/ace_cloud/callback', to: 'sessions#create'
  get '/auth/logout', to: 'sessions#destroy'

  scope :api do
    get '/get_user', to: 'sessions#get'
    resources :events, defaults: { format: 'json' } do
      resources :attendees, only: [:index, :destroy], defaults: { format: 'json' }
    end

    post '/sign_in/:id', to: 'attendees#create'
  end
end
