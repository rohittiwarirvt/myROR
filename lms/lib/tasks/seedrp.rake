namespace :import do
  desc "Searc Roles, Permission and users for working on site"
  task :seedrp1 => :environment do
    Role.delete_all
    Permission.delete_all
    puts "Deleted All Records Successfully"
    roles = Role.create([{role_name:'admin', title:'Admin'},{role_name:'user', title:'Customer'}])
    permissions = Permission.create([
          {permission_name:'create', title:'Create'},
          {permission_name:'read', title:'Read'},
          {permission_name:'update', title:'Update'},
          {permission_name:'delete', title:'Delete'}
        ])
    roles.each do |role|
      permissions.each do |perm|
        role.permissions << perm
        puts "Create record"
      end
    end
  end
end
