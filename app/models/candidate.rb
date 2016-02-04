class Candidate < ActiveRecord::Base
  validates_uniqueness_of :necid

  def district_long
    "#{city}/#{district}"
  end
end
