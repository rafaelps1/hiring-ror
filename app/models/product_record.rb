class ProductRecord < ApplicationRecord
  self.table_name = 'products'

  belongs_to :user, class_name: 'UserRecord'
end
