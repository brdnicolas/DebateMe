Rails.application.routes.draw do
  get '/ping' => 'test#ping'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
