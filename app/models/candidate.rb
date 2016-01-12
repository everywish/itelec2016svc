class Candidate < ActiveRecord::Base
  validates :necid, uniqueness: true

  def district_long
    "#{city}/#{district}"
  end
end
