class Product < ApplicationRecord
  # validates :name, presence: true, uniqueness: true, length: { minimum: 1, maximum: 100 }
  # validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # validate :price, :price_is_valid_decimal_precision
  # validates :photo, presence: true,
  #                   format: {
  #                     with: %r{\A(http|https)://|[a-z0-9]+([-.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(/.*)?\z}
  #                   }

  belongs_to :user

  # scope :active, -> { where(state: true) }
  # scope :filter_by_name, ->(term) { where('lower(name) LIKE ?', "%#{term.downcase}%") }
end
