class Coach < ApplicationRecord
  belongs_to :teams
  belongs_to :person
end
