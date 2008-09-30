require 'rubygems'
require 'need'
need { 'spec_helper' }

describe "Taza Tasks" do
  
  before :all do
    @file_name ="./lib/tasks/taza_tasks.rb"
    @rake = Rake::Application.new
    Rake.application = @rake
  end
  
  after :all do
    Rake.application = nil 
  end
  
  it "should create a rake task to run test unit tests marked with tags" do
    load @file_name 
    tasks.include?("test_tag").should be_true
  end
  
  it "should create a rake task to run specs marked with tags" do
    load @file_name 
    tasks.include?("spec_tag").should be_true
  end

  it "should create a rake task to generate a site" do
    load @file_name
    tasks.include?("generate:site").should be_true
  end

  it "should create a rake task to generate a page" do
    load @file_name
    tasks.include?("generate:page").should be_true
  end

  def tasks
    @rake.tasks.collect{|task| task.name }
  end

end

describe "Site generation task" do
  
  before :all do
    @file_name ="./lib/tasks/taza_tasks.rb"
    @rake = Rake::Application.new
    Rake.application = @rake
  end
  
  it "should create a site file in lib/sites" do
    SiteGenerator.any_instance.expects(:file).with('site.rb.erb','lib/sites/foo.rb')
    SiteGenerator.any_instance.expects(:folder).with('lib/sites/foo')
    SiteGenerator.any_instance.expects(:folder).with('lib/sites/foo/flows')
    SiteGenerator.any_instance.expects(:folder).with('lib/sites/foo/pages')
    load @file_name 
    ENV['name'] = 'foo'
    @rake.invoke_task("generate:site")
  end
  
end
