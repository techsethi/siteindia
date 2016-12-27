Rails.application.routes.draw do
  root to: 'visitors#index'

  get '/auth/:provider/callback', to: 'sessions#create'

  get '/posts/image_info', to: 'posts#image_info'
  get '/posts/analyze_image', to: 'posts#analyze_image'
  post '/posts/analyze_image', to: 'posts#analyze_image'
end
