if @errors.present?
  json.set! :errors do
    json.id @errors[:id]
    json.title @errors[:message]
    json.status @errors[:status]
  end
end
