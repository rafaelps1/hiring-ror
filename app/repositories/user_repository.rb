class UserRepository
  include Repository

  attr_accessor :user
  attr_reader :record

  def initialize(user = nil)
    @user = user
    @errors = []
  end

  def destroy
    record&.destroy!
  end

  def fetch_by(options = {})
    @record = user_record.find_by(options)
    return if record.blank?

    build_user(record.attributes)
  end

  def save
    return if user.blank?

    @record = user_record.new(user&.attributes)
    return build_user(record.attributes) if record.save!
  end

  private

  def build_user(fields = {})
    return if fields.blank?

    @user = Entity::User.new(fields)
    user.record = record
    user
  end

  def user_record
    UserRecord
  end
end
