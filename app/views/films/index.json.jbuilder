json.total @films.total
json.data do
  json.array!(@films) do |film|
    json.extract! film, :id, :name, :mins,
      :year, :url, :gapoif
  end
end
