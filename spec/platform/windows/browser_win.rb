require 'spec/spec_helper'
require 'taza/browser'
require 'taza/settings'
require 'taza/options'
require 'selenium'
require 'watir'

describe Taza::Browser do

  before :each do
    Taza::Settings.stubs(:config_file).returns({})
    ENV['TAZA_ENV'] = 'isolation'
    ENV['SERVER_PORT'] = nil
    ENV['SERVER_IP'] = nil
    ENV['BROWSER'] = nil
    ENV['DRIVER'] = nil
    ENV['TIMEOUT'] = nil
  end
  it "should be able to attach to an open IE instance" do
    require 'watir'
    browser = Object.new
    Watir::IE.stubs(:find).returns(browser)
    Watir::IE.stubs(:new).returns(browser)
    old_browser = Watir::IE.new
    new_browser = Taza::Browser.create(:browser => :ie, :driver => :watir, :attach => true) 
    new_browser.should eql(old_browser)
  end
  
  it "should be able to open a new IE instance if there is no instance to attach to" do
    require 'watir'
    browser = Object.new
    Watir::IE.stubs(:find).returns()
    Watir::IE.stubs(:new).returns(browser)
    new_browser = Taza::Browser.create(:browser => :ie, :driver => :watir) 
    browser.nil?.should be_false 
  end
  it "should be able to open a new IE instance if attach not specified" do
    require 'watir'
    foo = Object.new
    bar = Object.new
    Watir::IE.stubs(:find).returns(foo)
    Watir::IE.stubs(:new).returns(bar)
    new_browser = Taza::Browser.create(:browser => :ie, :driver => :watir) 
    new_browser.should_not eql(foo)
  end

end
