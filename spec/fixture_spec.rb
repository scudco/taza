require 'spec_helper'
require 'taza/fixture'
require 'extensions/array'

describe Taza::Fixture do
  before :each do
    @base_path = File.join('.','spec','sandbox','fixtures','')
  end

  it "should be able to load entries from fixtures" do
    fixture = Taza::Fixture.new
    fixture.load_fixtures_from(@base_path)
    example = fixture.get_fixture_entity(:examples,'first_example')
    example.name.should eql("first")
    example.price.should eql(1)
  end

  it "should use the spec fixtures folder as the base path" do
    Taza::Fixture.base_path.should eql('./spec/fixtures/')
  end

  it "should know if a pluralized fixture of that name exists" do
    fixture = Taza::Fixture.new
    fixture.load_fixtures_from(@base_path)
    fixture.pluralized_fixture_exists?('example').should be_true
    fixture.pluralized_fixture_exists?('boo').should be_false
  end

  it "should be able to get all fixtures loaded excluding sub-folder fixtures" do
    fixture = Taza::Fixture.new
    fixture.load_fixtures_from(@base_path)
    fixture.fixture_names.should be_equivalent([:examples,:users,:foos])
  end

  it "should be able to get specific fixture entities" do
    fixture = Taza::Fixture.new
    fixture.load_fixtures_from(@base_path)
    examples = fixture.specific_fixture_entities(:examples, ['third_example'])
    examples.length.should eql(1)
    examples['third_example'].name.should eql('third')
  end

  it "should not modified the fixtures when you get specific entities off a fixture" do
    fixture = Taza::Fixture.new
    fixture.load_fixtures_from(@base_path)
    previous_count = fixture.get_fixture(:examples).length
    examples = fixture.specific_fixture_entities(:examples, ['third_example'])
    fixture.get_fixture(:examples).length.should eql(previous_count)
  end

 end
