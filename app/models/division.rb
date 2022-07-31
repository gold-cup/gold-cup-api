class Division < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true

  def in_bounds?(date)
    min_date <= date && date <= max_date
  end
end
