class Role < ApplicationRecord
  has_and_belongs_to_many :permissions, :join_table => 'roles_permissions'
  has_and_belongs_to_many :users, :join_table => 'users_roles'
  has_many :version_roles
  has_many :certificates
end
