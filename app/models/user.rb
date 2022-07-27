# frozen_string_literal: true

class User < ApplicationRecord
  SCOPES = ["user", "team_manager", "admin"]
  has_secure_password

  validates :name, presence: true

  validates :email, presence: true,
                    format: { with: /\S+@\S+/ },
                    uniqueness: { case_sensitive: false }
  validates :permission, inclusion: { in: SCOPES }
  has_many :people
  has_many :teams
end
