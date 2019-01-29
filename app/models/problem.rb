class Problem < ApplicationRecord
	has_and_belongs_to_many :user
	has_many :criterium
	has_many :solution
end
