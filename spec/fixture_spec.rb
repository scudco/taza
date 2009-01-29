require 'spec/spec_helper'
require 'taza'

describe Taza::Fixture do
  
  it "should be able to load entries from fixtures" do
    Taza::Fixture.any_instance.stubs(:base_path).returns('./spec/sandbox')
    fixture = Taza::Fixture.new
    fixture.load_all
    example = fixture.get_fixture_entity(:examples,'first_example')
    example.name.should eql("first")
    example.price.should eql(1)
  end

  it "should use the spec folder as the base path" do
    Taza::Fixture.new.base_path.should eql('./spec')
  end

  it "should know if a pluralized fixture of that name exists" do
    Taza::Fixture.any_instance.stubs(:base_path).returns('./spec/sandbox')
    fixture = Taza::Fixture.new
    fixture.load_all
    fixture.pluralized_fixture_exists?('example').should be_true
    fixture.pluralized_fixture_exists?('boo').should be_false
  end
  
  it "should be able to get all fixtures loaded" do
    Taza::Fixture.any_instance.stubs(:base_path).returns('./spec/sandbox')
    fixture = Taza::Fixture.new
    fixture.load_all
    fixture.fixture_names.should be_equivalent([:examples,:users,:foos])
  end

  it "should be able to get specific fixture entities" do
    Taza::Fixture.any_instance.stubs(:base_path).returns('./spec/sandbox')
    fixture = Taza::Fixture.new
    fixture.load_all
    examples = fixture.specific_fixture_entities(:examples, ['third_example'])
    examples.length.should eql(1)
    examples['third_example'].name.should eql('third')
  end

  it "should not modified the fixtures when you get specific entities off a fixture" do
    Taza::Fixture.any_instance.stubs(:base_path).returns('./spec/sandbox')
    fixture = Taza::Fixture.new
    fixture.load_all
    previous_count = fixture.get_fixture(:examples).length
    examples = fixture.specific_fixture_entities(:examples, ['third_example'])
    fixture.get_fixture(:examples).length.should eql(previous_count)
  end



end
