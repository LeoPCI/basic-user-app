class Solution < ApplicationRecord
  belongs_to :problem
  belongs_to :user
  has_many :poll
end
