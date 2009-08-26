require 'spec/spec_helper'
require 'extensions/string'

describe "string extensions" do
  it "should pluralize and to sym a string" do
    "apple".pluralize_to_sym.should eql(:apples)
  end
  
  it "should variablize words with spaces" do
    "foo -  BAR".variablize.should eql("foo_bar")
  end	
end
