class Program < ApplicationRecord
  has_many :courses, dependent: :destroy
end
