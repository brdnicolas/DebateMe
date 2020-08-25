Rails.application.routes.draw do
  get '/ping' => 'test#ping'

  resources :users
  resources :posts

  resources :themes do
    resources :questions
  end
  resources :reports

  post '/auth/login' => 'authentication#authenticate'
  post '/auth/register'   => 'users#create'

  get '/users/search/:search' => 'users#search'
  get '/users/me/profile' => 'users#show_me'
  get '/users/:id/achievements' => 'users#show_achievements'
  get '/users/:id/activity' => 'users#show_activities'

  delete '/posts/:id' => 'posts#destroy'
  get '/users/:user_id/posts' => 'posts#search_index'

  get '/questions/:id/posts' => 'questions#get_posts'

  get '/reports_reasons' => 'reports#get_reasons'

  get '/reports_sort' => 'reports#get_sorted_reports'

  get '/posts/:id/vote' => 'posts#vote'

end