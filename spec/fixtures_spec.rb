require 'spec_helper'


describe "Taza::Fixtures" do

  Taza::Fixture.stubs(:base_path).returns('./spec/sandbox/fixtures/')
  Taza.load_fixtures
  include Taza::Fixtures

  it "should be able to look up a fixture entity off fixture_methods module" do
    examples(:first_example).name.should eql('first')
  end

  it "should still raise method missing error" do
    lambda{zomgwtf(:first_example)}.should raise_error(NoMethodError)
  end

  #TODO: this test tests what is in entity's instance eval not happy with it being here
  it "should be able to look up a fixture entity off fixture_methods module" do
    examples(:first_example).user.name.should eql(users(:shatner).name)
  end

  it "should be able to resolve one to many relationships" do
    foos(:gap).examples.length.should eql(2)
  end

  it "should be able to get one to many entities" do
    foos(:gap).examples['first_example'].name.should eql('first')
    foos(:gap).examples['second_example'].name.should eql('second')
  end

  it "should not be able to access fixtures in sub-folders if not included" do
    lambda{bars(:foo)}.should raise_error(NoMethodError)
  end

  it "should template fixture files" do
    users(:shatner).age.should eql(66)
  end

  it "should be able to get one to many entities for hash[key] style" do
    foos(:gap)['examples']['first_example']['name'].should eql('first')
  end

  it "should be able to access multiple levels inside fixtures" do
    examples(:forth_example).something.user.name.should eql('William Shatner')
  end

end
