require 'spec_helper'
require 'account'

describe Profile do
  before :each do
    @account = Account.make
    @profile = Profile.new
  end

  it "should be invalid without an account" do
    @profile.should have(1).errors_on(:account)
    @profile.account = @account
    @profile.should have(:no).errors_on(:account)
  end
end