Rails.application.routes.draw do
  get 'rake/run'

  resources :users
  root 'static#home'
  post '/start_crawler' => 'rake#run'

end
