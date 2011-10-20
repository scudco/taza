require 'spec_helper'
require 'rubygems'
require 'rake'

describe "Taza Tasks" do

  before :all do
    @file_name ="./lib/taza/tasks.rb"
    @rake = Rake::Application.new
    Rake.application = @rake
  end

  before :each do
    Dir.expects(:glob).with('./spec/*/').returns(['./spec/functional/','./spec/mocks/'])
    Dir.expects(:glob).with('./spec/functional/*/').returns(['./spec/functional/foo/'])
    Dir.expects(:glob).with('./spec/functional/*_spec.rb').returns([])
    Dir.expects(:glob).with('./spec/functional/foo/*/').returns(['./spec/functional/foo/page/'])
    Dir.expects(:glob).with('./spec/functional/foo/*_spec.rb').returns([])
    Dir.expects(:glob).with('./spec/functional/foo/page/*/').returns([])
    Dir.expects(:glob).with('./spec/functional/foo/page/*_spec.rb').returns(['./spec/functional/foo/page/bar_spec.rb'])

    Dir.expects(:glob).with('./spec/functional/**/*_spec.rb').returns(['./spec/functional/foo/page/bar_spec.rb']).twice
    Dir.expects(:glob).with('./spec/functional/foo/**/*_spec.rb').returns(['./spec/functional/foo/page/bar_spec.rb']).twice
    Dir.expects(:glob).with('./spec/functional/foo/page/**/*_spec.rb').returns(['./spec/functional/foo/page/bar_spec.rb']).twice
    Dir.expects(:glob).with('./spec/mocks/**/*_spec.rb').returns([])
    Dir.expects(:glob).with('./spec/functional/foo/page/bar_spec.rb').returns(['./spec/functional/foo/page/bar_spec.rb'])

    load @file_name
    Taza::Rake::Tasks.new
  end

  after :all do
    Rake.application = nil
  end

  it "should create rake spec tasks for all sites" do
    tasks.include?("spec:functional:foo").should be_true
  end

  it "should create rake spec tasks for all sites page specs" do
    tasks.include?("spec:functional:foo:page").should be_true
  end

  it "should create rake spec tasks for all sites page specs in sub-folders" do
    tasks.include?("spec:functional:foo:page:bar").should be_true
  end

  it "should not create rake spec tasks for folders that donot contain specs in their sub-tree" do
    tasks.include?("spec:mocks").should be_false
  end

  def tasks
    @rake.tasks.collect{|task| task.name }
  end

end
