json.array! @apartments do |apartment|
  json.extract! apartment, :id, :name, :address
end
