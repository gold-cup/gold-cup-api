# frozen_string_literal: true

class TeamsController < ApplicationController
  def index
    teams = Team.all
    render json: teams, response: 200
  end

  def show
    check_if_user_manages_team
    team = Team.find(params[:id])
    players = team.players
    team.players = players
    render json: { **team.attributes, players: players }, response: 200
  end

  def create
    token_from_request = request.headers["Authorization"]
    user_id = decode_token(token_from_request)["user_id"]
    team = Team.new(team_params.merge(manager_id: user_id))
    team_password = generate_token(team.id)
    team.password = team_password
    if team.save
      render json: team, response: 201
    else
      render json: { errors: team.errors }, response: 422
    end
  end

  def update
    check_if_user_manages_team
    team = Team.find(params[:id])
    team.update(team_params)
    render json: team, response: 200
  end

  def players
    team = Team.find(params[:id])
    players = team.players
    render json: players, response: 200
  end

  def destroy
    begin
      check_if_user_manages_team
      team = Team.find(params[:id])
      team.destroy
      render json: { message: "Team deleted" }, response: 200
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Team not found" }, response: 404
    rescue JWT::VerificationError
      render json: { error: "You do not have permission to delete this team" }, response: 401
    end
  end

  private

  def decode_token(token)
    begin
      encoded_token = token
      puts encoded_token
      if (encoded_token)
        token = encoded_token.split(' ').last
        decoded_token = JWT.decode(token, ENV['APP_SECRET'], true, algorithm: 'HS256')
        payload = decoded_token[0]
        payload
      else
        puts "No token found"
      end
    rescue JWT::DecodeError
      puts "Invalid token"
    end
  end

  def check_if_user_manages_team
    token_from_request = request.headers["Authorization"]
    user_id = decode_token(token_from_request)["user_id"]
    team = Team.find(params[:id])
    if (team.manager_id != user_id)
      render json: {error: "You don't have permission to do that"}, status: 401
      return
    end
  end

  def generate_token(team_id)
    payload = { team_id: team_id }
    token = JWT.encode payload, ENV['APP_SECRET'], 'HS256'
  end

  def team_params
    params.require(:team).permit(:name, :division)
  end
end
