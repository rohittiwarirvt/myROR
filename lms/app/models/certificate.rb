class Certificate < ActiveRecord::base
  has_and_belongs_to_many :courses, join_table :'courses_certificates'
end
