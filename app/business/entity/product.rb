module Entity
  class Product < Dry::Struct
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

    attribute? :id, Types::Coercible::Integer
    attribute :name, Types::String
    attribute? :title, Types::String.optional
    attribute :price, Types::Coercible::Float.default(0)
    attribute? :photo, Types::String.optional
    attribute :state, Types::Bool.default(true)
  end
end
