require 'dry/validation'

module Schemas
  AddressSchema = Dry::Schema.Params do
    required(:country).value(:string)
    required(:zipcode).value(:string)
    required(:street).value(:string)
  end

  ContactSchema = Dry::Schema.Params do
    required(:email).value(:string)
  end
end
