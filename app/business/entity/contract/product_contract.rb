require 'dry/validation/contract'
module Entity
  module Contract
    class ProductContract < Dry::Validation::Contract
      schema do
        optional(:id)
        required(:name).value(:string)
        optional(:title).value(:string)
        required(:price).value(:float)
        optional(:photo).value(:string)
        required(:state).value(:bool)
      end

      rule(:name) do
        name = values[:name]
        key.failure(I18n.t('dry_validation.errors.product.is_exist'))     if ProductRecord.where(name: name).first
        key.failure(I18n.t('dry_validation.errors.product.name_length'))  if name.empty? || name.length > 100
      end

      rule(:price) do
        price = values[:price]
        key.failure(I18n.t('dry_validation.errors.product.price_negative')) if price.negative?
        key.failure(I18n.t('dry_validation.errors.product.price_digit')) if price != price.to_f.round(2)
      end

      rule(:photo) do
        photo = values[:photo]
        valid = %r{\A(http|https)://|[a-z0-9]+([-.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(/.*)?\z}.match?(photo)

        key.failure(I18n.t('dry_validation.errors.product.photo_url')) if photo.present? && !valid
      end
    end
  end
end
