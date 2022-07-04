class TeamsController < ApplicationController
  def index
    teams = Team.all
    render json: teams, response: 200
  end

  def show
    team = Team.find(params[:id])
    players = team.players
    team.players = players
    response = {
      id: team.id,
      name: team.name,
      division: team.division,
      points: team.points,
      players: players
    }
    render json: response, response: 200
  end

  def create
    team = Team.create(team_params)
    render json: team, response: 201
  end

  def update
    team = Team.find(params[:id])
    team.update(team_params)
    render json: team, response: 200
  end

  def players
    team = Team.find(params[:id])
    players = team.players
    render json: players, response: 200
  end

  private

  def team_params
    params.require(:team).permit(:name, :division)
  end

end
