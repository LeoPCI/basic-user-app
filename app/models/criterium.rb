class Criterium < ApplicationRecord
  belongs_to :problem
  has_and_belongs_to_many :user
  has_many :cridissent
  has_many :poll
end
