# frozen_string_literal: true

class Player < ApplicationRecord
  belongs_to :team
  belongs_to :person
end
