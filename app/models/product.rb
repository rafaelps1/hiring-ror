class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 1, maximum: 100 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :price, :price_is_valid_decimal_precision
  validates :photo, presence: true, format: { with: /\A(http|https):\/\/|[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?\z/ }

  belongs_to :user

  private

  def price_is_valid_decimal_precision
    if price != price.to_f.round(2)
      errors.add(:price, 'The price should only be two digits of the decimal point.')
    end
  end
end
