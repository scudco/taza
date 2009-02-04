require 'spec/spec_helper'
require 'taza/fixture'

describe "Site Specific Fixtures" do
  include Taza::Fixtures::FooSite
 
  it "should be able to access fixtures in sub-folders" do
    bars(:foo).name.should eql("foo")
  end

  it "should not be able to access non-site-specific fixtures" do
    lambda{foos(:gap)}.should raise_error(NoMethodError)
  end

end
