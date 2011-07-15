

namespace :credits do
  task :init => :environment do
    Product.credit_tiers
    [
      {:name => "5 Credits", :description => "5 Credits for up to 5 sounds", :price => 500, :credit_value => 5, :kind => 'Credit'},
      {:name => "10 Credits", :description => "10 Credits for up to 10 sounds", :price => 950, :credit_value => 10, :kind => 'Credit'},
      {:name => "25 Credits", :description => "25 Credits for up to 25 sounds", :price => 2200, :credit_value => 25, :kind => 'Credit'},
      {:name => "50 Credits", :description => "50 Credits for up to 50 sounds", :price => 4500, :credit_value => 50, :kind => 'Credit'}
    ].each do |product|
      Product.create(product)
    end
    
  end
end