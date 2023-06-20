if @errors.blank?
  json.set! :data do
    json.email @user.email
  end
else
  json.errors @errors do |err|
    json.message err
  end
end
