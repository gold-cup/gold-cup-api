Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/teams" => "teams#index"
  get "/teams/:id" => "teams#show"
  get "/players/:id" => "players#show"
  get "/teams/:id/players" => "teams#players"
  get "/user" => "users#show"
  get "/people" => "users#personal_details"
  get "/person" => "users#index"
  get "/person/:id/players/:player_id" => "players#show"
  get "/person/:id" => "people#show"
  get "/files/get" => "files#get_file"
  get "/teams" => "user#get_teams"
  get "/person/:id/players" => "players#index"

  post "/team/new" => "teams#create"
  post "/login" => "users#login"
  post "/register" => "users#create"
  post "/person/new" => "people#create"
  post "/files/token" => "files#create_token"
  post "/user/request_team_manager_permissions" => "users#request_team_manager_permissions"
  post '/players/new' => 'players#create'

  put "/teams/:id" => "teams#update"
  put "/give_team_manager_permission" => "users#give_team_manager_permission"
  put "/person/:id" => "people#update"

  delete "/person/:id" => "people#destroy"
  delete "/team/:id" => "teams#destroy"
end
