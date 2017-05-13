class RolesAndPermission < ActiveRecord::Migration[5.0]
  def change
      create_table :roles do |t|
        t.string :role_name
        t.string :title
        t.timestamps
      end

      create_table :permissions do |t|
        t.string :permission_name
        t.string :title
        t.timestamps
      end

      create_table :roles_permissions, id: false do |t|
        t.belongs_to :role, index: true
        t.belongs_to :permission, index: true
      end

      create_table :users_roles, id: false do |t|
        t.belongs_to :role, index: true
        t.belongs_to :user, index: true
      end
    end
end
