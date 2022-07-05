Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/teams" => "teams#index"
  get "/teams/:id" => "teams#show"
  get "/players" => "players#index"
  get "/players/:id" => "players#show"
  get "/teams/:id/players" => "teams#players"

  post "/teams" => "teams#create"

  put "/teams/:id" => "teams#update"
end
