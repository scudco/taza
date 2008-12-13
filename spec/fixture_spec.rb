require 'spec/spec_helper'
require 'taza'

describe Taza::Fixture do
  
  it "should create a Fixture for each fixture file" do
    Taza::Fixture.stubs(:base_path).returns('./spec/sandbox')
    fixtures = Taza::Fixture.load_all
    fixtures.size.should eql(2)
  end

  it "should create a Fixture from a yaml file" do
    fixture = Taza::Fixture.load_file('./spec/sandbox/fixtures/examples.yml')
    fixture.entities.size.should eql(2)
  end

  it "should create a Fixture with a name from yaml file" do
    fixture = Taza::Fixture.load_file('./spec/sandbox/fixtures/examples.yml')
    fixture.name.should eql('examples')
  end

  it "should create a Fixture with Entities" do
    fixture = Taza::Fixture.load_file('./spec/sandbox/fixtures/examples.yml')
    entity = fixture.entity('first_example')
    entity.name.should eql("first")
    entity.price.should eql(1)
  end

  it "should load fixture files from the fixtures_pattern" do
    Taza::Fixture.stubs(:base_path).returns('./spec/sandbox')

  end

  it "should use the spec folder as the base path" do
    Taza::Fixture.base_path.should eql('./spec')
  end

  it "should know if a pluralized fixture of that name exists"

end
