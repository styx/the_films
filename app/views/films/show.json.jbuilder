json.extract! @film, :id, :name, :second_name,
  :gapoif, :url, :year, :mins

json.kind do
  json.partial! 'kinds/kind', kind: @film.kind
end

json.genres do
  json.array! @film.genres do |genre|
    json.partial! 'genres/genre', genre: genre
  end
end
