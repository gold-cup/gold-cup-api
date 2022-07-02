class TeamsController < ApplicationController
  def index
    teams = Team.all
    render json: teams, response: 200
  end

  def show
    team = Team.find(params[:id])
    render json: team, response: 200
  end
end
