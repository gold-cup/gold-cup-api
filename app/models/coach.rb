class Coach < ApplicationRecord
  STATUSES = ["pending", "approved", "needs_changes"]
  belongs_to :team
  belongs_to :person
  has_one_attached :certificate, dependent: :destroy
  validates :status, inclusion: { in: STATUSES }
end
