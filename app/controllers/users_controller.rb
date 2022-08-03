require 'jwt'

class UsersController < ApplicationController
  def create
    puts user_params
    user = User.new(user_params)
    if user.save
      token = generate_token(user)
      render json: {user: user, token: token}, response: 201
    else
      render json: {errors: user.errors}, response: 422
    end
  end

  def show
    begin
      user_id_from_token = decode_token(request)["user_id"]
      user = User.find(user_id_from_token)
      render json: filter_response(user), response: 200
    rescue JWT::VerificationError
      render json: {error: 'failed to decode token'}, resposne: 401
    end
  end


  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = generate_token(user)
      render json: {**user.attributes, token: token}, response: 200
    else
      render json: { error: 'Invalid username or password' }, response: 401
    end
  end

  def index
    begin
      user_id_from_token = decode_token(request)["user_id"]
      user = User.find(user_id_from_token)
      personal_details = user.people
      render json: personal_details, response: 200
    rescue JWT::VerificationError
      render json: {error: 'failed to decode token'}, resposne: 401
    end
  end

  def request_team_manager_permissions
    begin
      user_id_from_token = decode_token(request)["user_id"]
      user = User.find(user_id_from_token)
      user.permission = "team_manager"
      if (user.save)
        render json: {message: "You have been granted team manager permissions"}, response: 200
      else
        render json: {errors: user.errors}, response: 422
      end
    rescue JWT::VerificationError
      render json: {error: 'failed to decode token'}, resposne: 401
    end
  end

  def get_teams
    begin
      user_id_from_token = decode_token(request)["user_id"]
      user = User.find(user_id_from_token)
      teams = user.teams
      render json: teams, response: 200
    rescue JWT::VerificationError
      render json: {error: 'failed to decode token'}, resposne: 401
    end
  end

  def get_all_players
    user_id = decode_token(request)["user_id"]
    user = User.find(user_id)
    players = user.players
    responseArr = players.map do |player|
      generate_player_response(player, include_person: "true", include_team: "true")
    end
    render json: responseArr, response: 200
  end

  def get_approved_people
    user_id = decode_token(request)["user_id"]
    user = User.find(user_id)
    players = user.people.filter_by_status("approved")
    render json: players, response: 200
  end

  def get_all_coaches
    user_id = decode_token(request)["user_id"]
    user = User.find(user_id)
    coaches = user.coaches
    responseArr = coaches.map do |coach|
      generate_coach_response(coach)
    end
    render json: responseArr, response: 200
  end

  private
  def user_params
    params.permit(:name, :email, :password)
  end

  def generate_token(user)
    payload = { user_id: user.id }
    token = JWT.encode payload, ENV['APP_SECRET'], 'HS256'
  end

  def filter_response(user)
    user.attributes.except("password_digest")
  end

end
