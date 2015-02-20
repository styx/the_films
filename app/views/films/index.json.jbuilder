json.array!(@films) do |film|
  json.extract! film, :id, :name, :mins,
    :year, :url, :gapoif
  json.url film_url(film, format: :json)
end
