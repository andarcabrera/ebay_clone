Rails.application.routes.draw do
 root 'items#index'
 get  "/items/new" =>  "items#new"
 post "/items"     =>  "items#create"
end
