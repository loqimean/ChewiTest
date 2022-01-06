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
                  fl.exclude(/\btmp\b/)
                  fl.exclude(/\bnode_modules\b/)
                  fl.exclude(/\bpublic\b/)
                  fl.exclude(/\bcoverage\b/)
                end

project_items.each do |path|
  pn = Pathname.new(path)
  folder_names = pn.relative_path_from(Rails.root).each_filename.to_a

  if pn.file?
    file_name = pn.basename.to_s
    folder_id = Folder.find_or_create_folder_by_names(folder_names[0..-2])

    Item.create!(name: file_name, folder_id: folder_id, attachment: Rack::Test::UploadedFile.new(path))
  else
    Folder.find_or_create_folder_by_names(folder_names)
  end
end

puts 'Finished seeding'.green
