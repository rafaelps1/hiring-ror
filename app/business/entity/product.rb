module Entity
  class Product < StructBase
    attr_accessor :user_id

    attribute? :id, Types::Coercible::Integer
    attribute :name, Types::String
    attribute? :title, Types::String.optional
    attribute :price, Types::Coercible::Float.default(0)
    attribute? :photo, Types::String.optional
    attribute :state, Types::Bool.default(true)
  end
end
