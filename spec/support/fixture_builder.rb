require 'ap'
FixtureBuilder.configure do |fbuilder|
  # rebuild fixtures automatically when these files change:
  fbuilder.files_to_check += Dir[Rails.root.join("db","seeds","*.rb"),"spec/support/fixture_builder.rb", "spec/support/blueprints.rb"]
  fbuilder.record_name_fields = ["email"]
  
  # now declare objects
  fbuilder.factory do
    Dir[Rails.root.join("db","seeds","*.rb")].sort.each do |seed_file|
      require seed_file
    end
  end
end