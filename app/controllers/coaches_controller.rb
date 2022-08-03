class CoachesController < ApplicationController
  def index
    check_if_user_owns_person(request, params[:id])
    coaches = Person.find(params[:id]).coaches
    responseArr = coaches.map do |coach|
      generate_coach_response(coach)
    end
    render json: responseArr, status: 200
  end

  def show
    check_if_user_owns_person(request, params[:id])
    person = Person.find(params[:id])
    coach = person.coaches.find(params[:coach_id])
    response = generate_coach_response(coach)
    render json: response, status: 200
  end

  def create
    check_if_user_owns_person(request, params[:person_id])
    coach = Coach.new(coach_params.merge(status: "pending"))
    if (coach.save)
      render json: generate_coach_response(coach), status: 201
    else
      render json: {errors: coach.errors}, response: 422
    end
  end

  def update
    check_if_user_owns_person(request, params[:id])
    person = Person.find(params[:id])
    coach = person.coaches.find(params[:coach_id])
    if (coach.update(coach_params))
      render json: generate_coach_response(coach), status: 200
    else
      render json: {errors: coach.errors}, response: 422
    end
  end

  def destroy
    check_if_user_owns_person(request, params[:id]) and return
    person = Person.find(params[:id])
    coach = person.coaches.find(params[:coach_id])
    destroyed_coach = coach.destroy
    if destroyed_coach.destroyed?
      render json: {message: "Player removed"}, status: 200
    else
      render json: {errors: player.errors}, response: 422
    end
  end

  private
  def coach_params
    params.permit(:team_id, :person_id, :certificate)
  end
end
