json.errors @errors do |error|
  json.id error[:id]
  json.title error[:message]
  json.status error[:status]
end
