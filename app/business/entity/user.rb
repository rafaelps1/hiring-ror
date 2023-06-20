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

    # add in the product service?
    def products_build(product_params)
      record&.products&.build(product_params)
    end
  end
end
