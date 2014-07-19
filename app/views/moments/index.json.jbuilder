json.array!(@moments) do |moment|
  json.extract! moment, :id, :body, :score
  json.url moment_url(moment, format: :json)
end
