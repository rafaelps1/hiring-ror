json.errors @erros do |error|
  json.id error[:id]
  json.title error[:message]
  json.status error[:status]
end
