Rails.application.routes.draw do
  resources :articles
  get '/api/ping/', to: "posts#index"
  get '/api/posts/', to: "posts#get_posts"
  resources :posts
end
