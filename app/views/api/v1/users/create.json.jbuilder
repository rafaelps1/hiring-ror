if @errors.blank?
  json.set! :data do
    json.email @user.email
  end
else
  json.erros @errors do |err|
    json.message err.full_message
  end
end
