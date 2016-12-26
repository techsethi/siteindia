Rails.application.routes.draw do
  root to: 'visitors#index'
  get ':controller(/:action(/:id))'
  get '/auth/:provider/callback', to: 'sessions#create'

end
