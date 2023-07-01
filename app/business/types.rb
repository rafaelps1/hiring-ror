require 'dry-monads'
include Dry::Monads[:maybe]
require 'dry-struct'

Dry::Types.load_extensions(:maybe)

module Types
  include Dry.Types()

  Undefined = Dry::Types::Undefined
end
