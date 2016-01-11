json.array!(@candidates) do |candidate|
  json.extract! candidate, :id, :necid, :city, :district, :party, :picture, :name, :gender, :age, :address, :occupation, :education, :career, :criminal_record
  json.url candidate_url(candidate, format: :json)
end
