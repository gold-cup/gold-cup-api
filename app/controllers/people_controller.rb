class PeopleController < ApplicationController
  def create
    auth_header = request.headers["Authorization"]
    user_id = decode_token(auth_header)["user_id"]
    person = Person.new(person_params.merge(user_id: user_id, status: "pending"))
    if (person.save)
      render json: person, status: 201
    else
      return render json: {errors: person.errors}, response: 422
    end
  end

  def update
    auth_header = request.headers["Authorization"]
    check_if_user_owns_person(token_from_request, params[:id]) and return
    person = Person.find(params[:id])
    if (person.update(person_params))
      render json: person, status: 200
    else
      render json: {errors: person.errors}, response: 422
    end
  end

  def destroy
    auth_header = request.headers["Authorization"]
    check_if_user_owns_person(token_from_request, params[:id]) and return
    person = Person.find(params[:id])
    destroyed_person = person.destroy
    if destroyed_person.destroyed?
      render json: {message: "Person removed"}, status: 200
    else
      render json: {errors: person.errors}, response: 422
    end
  end

  def show
    auth_header = request.headers["Authorization"]
    check_if_user_owns_person(token_from_request, params[:id]) and return
    person = Person.find(params[:id])
    return render json: person, status: 200
  end

  private

  def person_params
    params.permit(
      :first_name,
      :last_name,
      :middle_name,
      :city,
      :province,
      :country,
      :email,
      :birthday,
      :gender,
      :phone_number,
      :waiver,
      :photo,
      :gov_id,
      :parent_email
    )
  end

  def check_if_user_owns_person(auth_header, person_id)
    user_id = decode_token(auth_header)["user_id"]
    person = Person.find(person_id)
    if (person.user_id != user_id)
      return render json: {error: "You don't have permission to do that"}, status: 401
    end
  end
end
