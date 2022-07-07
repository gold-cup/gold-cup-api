# frozen_string_literal: true

class PlayersController < ApplicationController
  def index
    players = Player.all
    responseArr = players.map do |player|
      generate_player_response(player)
    end
    render json: responseArr, status: 200
  end

  def show
    player = Player.find(params[:id])
    responseArr = generate_player_response(player)
    render json: responseArr, status: 200
  end

  private

  def generate_player_response(player)
    { **player.attributes, team: player.team }
  end
end
