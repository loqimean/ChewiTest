# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Start seeding users'.green

Chewy.strategy(:atomic) do
  25.times do
    city = City.new
    city.name = Faker::Address.country
    user = city.users.build
    user.name = Faker::Name.first_name
    user.email = Faker::Internet.email
    user.seniority = Faker::Job.seniority
    city.save!
  end
end

puts 'Start seeding VirtualDrive:'.green

project_items = Rake::FileList.new(Rails.root.join('**', '*')) do |fl|
                  fl.exclude(/\bpublic\b/)
                  fl.exclude(/\btmp\b/)
                  fl.exclude(/\bnode_modules\b/)
                  fl.exclude(/\bcoverage\b/)
                end

project_items.each do |path|
  pn = Pathname.new(path)
  relative_path = pn.relative_path_from(Rails.root)

  if pn.file?
    *array_of_folder_names, file_name = relative_path.each_filename.to_a
    relative_path_without_file = array_of_folder_names.join('/')
    folder = Folder.find_or_create_by_path(relative_path_without_file)

    Item.create!(name: file_name.to_s, folder: folder, attachment: Rack::Test::UploadedFile.new(path))
  else
    Folder.find_or_create_by_path(relative_path.to_s)
  end
end

puts 'Finished seeding'.green
