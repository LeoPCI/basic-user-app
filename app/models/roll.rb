class Roll < ApplicationRecord
  belongs_to :activity
  has_and_belongs_to_many :user
end
