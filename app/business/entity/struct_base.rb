module Entity
  class StructBase < Dry::Struct
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
  end
end
