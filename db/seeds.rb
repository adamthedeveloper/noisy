# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
seeds_dir = Rails.root.join("db","seeds")
Dir[seeds_dir + "/*.rb"].sort.each do |seed_file|
  ap seed_file
  require seed_file
end