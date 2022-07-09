class Person < ApplicationRecord
  GENDERS = ["male", "female"]
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :city, presence: true
  validates :province, presence: true
  validates :country, presence: true
  validates :phone_number, presence: true

  validates :email, format: {
    with: /\S+@\S+/,
  }, uniqueness: true

  validates :birthday, presence: true
  validates :gender, inclusion: {
    in: GENDERS
  }


end
