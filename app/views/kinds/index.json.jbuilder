json.array!(@kinds) do |kind|
  json.extract! kind, :id, :name
end
