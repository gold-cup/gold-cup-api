# frozen_string_literal: true

class PlayersController < ApplicationController
  def index
    check_if_user_owns_person(request, params[:id])
    players = Person.find(params[:id]).players
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

  def create
    check_if_user_owns_person(request, params[:person_id])
    player = Player.new(player_params)
    if (player.save)
      render json: generate_player_response(player), status: 201
    else
      render json: {errors: player.errors}, response: 422
    end
  end

  def show
    check_if_user_owns_person(request, params[:id])
    person = Person.find(params[:id])
    player = person.players.find(params[:player_id])
    response = generate_player_response(player)
    render json: response, status: 200
  end

  def update
    check_if_user_owns_person(request, params[:id])
    person = Person.find(params[:id])
    player = person.players.find(params[:player_id])
    if (player.update(player_params))
      render json: generate_player_response(player), status: 200
    else
      render json: {errors: player.errors}, response: 422
    end
  end

  def destroy
    check_if_user_owns_person(request, params[:id])
    person = Person.find(params[:id])
    player = person.players.find(params[:player_id])
    destroyed_player = player.destroy
    if destroyed_player.destroyed?
      render json: {message: "Player removed"}, status: 200
    else
      render json: {errors: player.errors}, response: 422
    end
  end

  private

  def generate_player_response(player)
    { **player.attributes.except("person_id", "team_id"), team: player.team, person: player.person }
  end

  def player_params
    params.permit(:team_id, :person_id, :number, :position)
  end
end
