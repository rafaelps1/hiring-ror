module Entity
  class User < StructBase
    attr_accessor :record
    attr_reader :errors

    attribute? :id, Types::Coercible::Integer
    attribute :name, Types::Coercible::String
    attribute :email, Types::String
    attribute? :password_digest, Types::String
    attribute? :password, Types::String

    delegate :authenticate, to: :record
  end
end
