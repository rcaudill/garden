json.array!(@readings) do |reading|
  json.extract! reading, :reading, :time_stamp
  json.url reading_url(reading, format: :json)
end