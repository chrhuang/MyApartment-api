json.data do
  json.apartments do
    json.array! @apartments do |apartment|
      json.extract! apartment, :id, :name, :address
    end
  end
end
