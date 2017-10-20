namespace :import do
  desc "ImporT the Categories"
  task :seedcategory => :environment do
    categories = [
              'Tackle',
              'Flag',
            'Both',
            ]
    category_collection = categories.map { |category| [name:category]}
    categories = Category.create(category_collection)
  end
end
