class Candidate < ActiveRecord::Base
  validates :necid, uniqueness: true
end
