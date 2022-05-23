Rails.application.routes.draw do
  resources :articles
  get '/api/ping/', to: "drinks#index"
  get '/api/drinks/', to: "drinks#get_drinks"
  resources :posts
end
