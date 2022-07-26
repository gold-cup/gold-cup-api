Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/teams" => "teams#index"
  get "/teams/:id" => "teams#show"
  get "/players" => "players#index"
  get "/players/:id" => "players#show"
  get "/teams/:id/players" => "teams#players"
  get "/user" => "users#show"
  get "/people" => "users#personal_details"
  get "/person/:id" => "people#show"
  get "/files/token" => "files#create_token"
  get "/files/get" => "files#get_file"

  post "/teams" => "teams#create"
  post "/login" => "users#login"
  post "/register" => "users#create"
  post "/person/new" => "people#create"

  put "/teams/:id" => "teams#update"
  put "/give_team_manager_permission" => "users#give_team_manager_permission"
  put "/person/:id" => "people#update"

  delete "/person/:id" => "people#destroy"
end
