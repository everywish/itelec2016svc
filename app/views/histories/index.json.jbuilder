json.array!(@histories) do |history|
  json.extract! history, :id, :rawdata
  json.url history_url(history, format: :json)
end
