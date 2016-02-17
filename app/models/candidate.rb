class Candidate < ActiveRecord::Base
  validates_uniqueness_of :necid

  belongs_to :history

  def district_long
    "#{city}/#{district}"
  end
end
