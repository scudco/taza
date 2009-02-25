require 'spec/spec_helper'
require 'extensions/string'

describe "string extensions" do
  it "should pluralize and to sym a string" do
    "apple".pluralize_to_sym.should eql(:apples)
  end
end
