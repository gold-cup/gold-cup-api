class Person < ApplicationRecord
  GENDERS = ["male", "female"]
  STATUSES = ["pending", "approved", "needs_changes"]
  belongs_to :user
  has_one_attached :waiver, dependent: :destroy
  has_one_attached :photo, dependent: :destroy
  has_one_attached :gov_id, dependent: :destroy

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

  validates :status, inclusion: {
    in: STATUSES
  }
end
