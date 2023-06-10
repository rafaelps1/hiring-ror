module Entity
  class User < Dry::Struct
    transform_keys(&:to_sym)
    transform_types do |type|
      if type.default?
        type.constructor do |value|
          value.nil? ? Types::Undefined : value
        end
      else
        type
      end
    end

    attr_accessor :record
    attr_reader :errors

    attribute? :id, Types::Coercible::Integer
    attribute :name, Types::Coercible::String
    attribute :email, Types::String
    attribute? :password_digest, Types::String
    attribute? :password, Types::String

    def authenticate(password)
      record&.authenticate(password)
    end

    def save
      result = Contract::UserContract.new.call(attributes)
      @errors = result.errors.to_a.map { |err| "#{err.path} #{err.text}" }
      return false if @errors.any?

      UserRecord.new(attributes)&.save
    end

    def products_build(product_params)
      record&.products&.build(product_params)
    end

    def self.fetch_by(option = {})
      id = option[:id]
      email = option[:email]
      return build(UserRecord.find_by_id(id)) if id

      return unless email

      build(UserRecord.find_by_email(email))
    end

    def self.build(record)
      return unless record.present? && record.attributes.any?

      entity_user = new(record.attributes)
      entity_user.record = record
      entity_user
    end
  end
end
