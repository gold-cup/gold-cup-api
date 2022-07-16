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

  private

  def generate_coach_response
    { **coach.attributes.except("person_id", "team_id"), team: coach.team, person: coach.person }
  end
end
