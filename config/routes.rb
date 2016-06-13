Rails.application.routes.draw do
  root "items#index"
  get  "/items"                             =>  "items#index"
  get  "/items/new"                         =>  "items#new"
  post "/items"                             =>  "items#create"
  get  "/items/:id"                         =>  "items#show", as: 'item'
  post "/items/:item_id/purchases"          =>  "purchases#create", as: 'create_purchase'
  get  "/items/:item_id/purchases/:id"      =>  "purchases#show"
  get  "/users/new"                         =>  "users#new"
  post "/users"                             =>  "users#create"
  get  "/login"                             =>  "sessions#new"
  post "/login"                             =>  "sessions#create"
  get  "/logout"                            =>  "sessions#destroy"
  post "/items/:item_id/bids"               =>  "bids#create", as: 'create_bid'
  get "/items/:item_id/bids/:id"            =>  "bids#show"
  get "/tags/:id"                           =>  "tags#show", as: 'tag'
end
