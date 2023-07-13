json.partial! partial: 'api/v1/share/errors_message'

if @user
  json.set! :data do
    json.id @user.id
    json.name @user.name
    json.email @user.email
  end
end
