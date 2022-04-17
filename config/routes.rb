Rails.application.routes.draw do
  get '/api/ping/', to: "posts#index"
  get '/api/posts/', to: "posts#get_posts"
  resources :posts
end
