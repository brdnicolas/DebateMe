Rails.application.routes.draw do
  get '/ping' => 'test#ping'

  resources :users do
    resources :posts
  end
  resources :themes do
    resources :questions
  end

  post '/auth/login' => 'authentication#authenticate'
  post '/register'   => 'users#create'
  get '/users/search/:search' => 'users#search_by_name'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
