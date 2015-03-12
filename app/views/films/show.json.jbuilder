json.extract! @film, :id, :name, :gapoif, :url, :year, :mins
json.kind do
  json.partial! 'kinds/kind', kind: @film.kind
end
