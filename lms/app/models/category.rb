class Category < ApplicationRecord
  has_many :versions, dependent: :destroy
end
