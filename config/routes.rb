Rails.application.routes.draw do
  get '/ping' => 'test#ping'

  resources :users do
    resources :posts
  end
  resources :themes do
    resources :questions
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
