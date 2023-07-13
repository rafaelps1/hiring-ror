json.partial! partial: 'api/v1/share/errors_message'

if @user.present?
  json.set! :data do
    json.email @user.email
  end
end
