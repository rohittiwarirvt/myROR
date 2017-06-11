class Category< ActiveRecord::Base
  has_many :versions, dependent: :destroy
end
