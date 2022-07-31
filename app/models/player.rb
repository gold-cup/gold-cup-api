# frozen_string_literal: true
require 'date'

class Player < ApplicationRecord
  belongs_to :team
  belongs_to :person
end
