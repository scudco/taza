require 'spec_helper'
require 'rubygems'
require 'rake'
require 'fileutils'

describe "Project Generator" do
  include RubiGen::GeneratorTestHelper

  before :all do
    @spec_helper = File.join(TMP_ROOT,PROJECT_NAME,'spec','spec_helper.rb')
    @rakefile = File.join(TMP_ROOT,PROJECT_NAME,'rakefile')
  end

  before :each do
    bare_setup
  end

  after :each do
    bare_teardown
  end

  it "should generate a spec helper that can be required" do
    run_generator('taza', [APP_ROOT], generator_sources)
    system("ruby -c #{@spec_helper} > #{null_device}").should be_true
  end

  it "should generate a rakefile that can be required" do
    run_generator('taza', [APP_ROOT], generator_sources)
    system("ruby -c #{@spec_helper} > #{null_device}").should be_true
  end

  it "should generate a console script" do
    run_generator('taza', [APP_ROOT], generator_sources)
    File.exists?(File.join(APP_ROOT,'script','console')).should be_true
  end

  it "should generate a windows console script" do
    run_generator('taza', [APP_ROOT], generator_sources)
    File.exists?(File.join(APP_ROOT,'script','console.cmd')).should be_true
  end

end
