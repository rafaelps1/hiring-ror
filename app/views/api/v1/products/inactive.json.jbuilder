json.errors @errors do |error|
  json.id error[:id]
  json.message error[:message]
  json.status error[:status]
end
