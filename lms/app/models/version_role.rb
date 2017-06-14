class VersionRole < ActiveRecord::Base
  belongs_to :role
  belongs_to :version
end
