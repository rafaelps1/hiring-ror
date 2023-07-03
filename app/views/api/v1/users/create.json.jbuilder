if @user.present?
  json.set! :data do
    json.email @user.email
  end
end

if @errors&.any?
  json.errors @errors do |err|
    json.message err
  end
end
