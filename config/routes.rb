Rails.application.routes.draw do
  get '/ping' => 'test#ping'

  resources :users
  resources :posts

  resources :themes do
    resources :questions
  end

  post '/auth/login' => 'authentication#authenticate'
  post '/auth/register'   => 'users#create'

  get '/users/search/:search' => 'users#search'

  get '/users/:user_id/posts' => 'posts#search_index'
  get '/users/:user_id/posts/:id' => 'posts#search_show'
  delete '/users/:user_id/post/:id' => 'posts#search_destroy'

  get '/questions/:id/posts' => 'questions#get_posts'

  get '/posts/:id/up' => 'posts#up_vote'
  get '/posts/:id/down' => 'posts#down_vote'

end