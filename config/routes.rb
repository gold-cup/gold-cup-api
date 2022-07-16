Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/teams" => "teams#index"
  get "/teams/:id" => "teams#show"
  get "/players" => "players#index"
  get "/players/:id" => "players#show"
  get "/teams/:id/players" => "teams#players"
  get "/user" => "users#show"
  get "/personal-details" => "users#personal_details"

  post "/teams" => "teams#create"
  post "/login" => "users#login"
  post "/register" => "users#create"
  post "/person/new" => "people#create"

  put "/teams/:id" => "teams#update"
  put "/give_team_manager_permission" => "users#give_team_manager_permission"
end
