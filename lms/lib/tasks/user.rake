namespace :import do
  desc "Create Couple of users and ad them roles"
  task :seeduser => :environment do
    User.delete_all
    puts "Deleted All users"

    users = User.create([
      {email:"admin@lms.com", first_name: 'Admin', last_name: 'Last Bro', password:'user123',password_confirmation:'user123'},
      {email:"user@lms.com", first_name: 'User', last_name: 'Last Bro', password:'user123',password_confirmation:'user123'}
      ])

    admin = Role.find_by_role_name('admin')
    user = Role.find_by_role_name('user')
    users.each do |u|
      res = case u.email
        when /admin/
          u.roles << admin
        else
          u.roles << user
        end
      puts "Added role for #{u.email} => #{u.roles.first.role_name}"
    end
  end
end
