class Assignment < ApplicationRecord
  has_many :course_assignments, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
end
