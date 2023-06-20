require 'dry/validation/contract'

module Entity
  module Contract
    class UserContract < Dry::Validation::Contract
      include Schemas

      schema(ContactSchema) do
        optional(:id)
        required(:name).value(:string)
        optional(:password_digest)
      end

      rule(:email) do
        email = values[:email]
        valid = /\A[^@]+@([^@.]+\.)+[^@.]+\z/.match?(email)

        key.failure(I18n.t('dry_validation.errors.user.email_invalid')) unless valid
        key.failure(I18n.t('dry_validation.errors.user.is_exist'))      if UserRepository.new.fetch_by(email: email)
      end
    end
  end
end
