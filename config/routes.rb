Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/teams" => "teams#index"
  get "/teams/:id" => "teams#show"
  get "/players" => "players#index"
  get "/players/:id" => "players#show"
  get "/teams/:id/players" => "teams#players"
  get "/user" => "users#show"

  post "/teams" => "teams#create"
  post "/login" => "users#login"
  post "/register" => "users#create"

  put "/teams/:id" => "teams#update"
end
