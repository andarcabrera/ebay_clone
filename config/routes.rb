Rails.application.routes.draw do
  root "items#index"
  get  "/items"                             =>  "items#index"
  get  "/items/new"                         =>  "items#new"
  post "/items"                             =>  "items#create"
  get  "/items/:item_id/purchases/new"      =>  "purchases#new", as: 'new_purchase'
  post "/items/:item_id/purchases"          =>  "purchases#create"
  get  "/items/:item_id/purchases/:id"      =>  "purchases#show"
  get  "/users/new"                         =>  "users#new"
  post "/users"                             =>  "users#create"
  get  "/login"                             =>  "sessions#new"
  post "/login"                             =>  "sessions#create"
  get  "/logout"                            =>  "sessions#destroy"
end
