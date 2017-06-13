namespace :import do
  desc "Imporint roles for verions"
  task :seedvr => :environment do
    roles = [
            ['commisioner', 'Commisioner'],
            ['coach','Coach'],
            ['official','Official'],
            ['parent','Parent'],
            ['player','Player'],
    ]

    roles_collection = roles.map { |role| [role_name:role[0],title:role[1]]}

    roles = Role.create(roles_collection)
  end
end
