class UserRepository
  include Repository

  attr_accessor :user
  attr_reader :record, :errors

  def initialize(user = nil)
    @user = user
    @errors = []
  end

  def destroy
    record&.destroy
  end

  def fetch_by(options = {})
    return if options[:id].blank? && options[:email].blank?

    @record = user_record.find_by(options)
    build_user
  end

  def save
    return if user.blank?

    @record = user_record.new(user&.attributes)
    if record.save!
      user.record = record
      user
    end
  rescue ActiveRecord::ActiveRecordError => e
    @errors = { code: 100, message: e.message }
  end

  private

  def build_user
    return if record.blank?

    attrs = record&.attributes
    @user = Entity::User.new(attrs)
    user.record = record
    user
  end

  def user_record
    UserRecord
  end
end
