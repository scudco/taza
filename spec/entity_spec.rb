require 'spec_helper'
require 'taza/entity'

describe Taza::Entity do
  it "should add methods for hash string keys" do
    entity = Taza::Entity.new({'apple' => 'pie'},nil)
    entity.should respond_to(:apple)
  end

  it "should be accessible like a hash(foo[:bar])" do
    entity = Taza::Entity.new({:apple => 'pie'},nil)
    entity[:apple].should eql('pie')
  end

  it "should be able to define methods for multiple levels" do
    entity = Taza::Entity.new({:fruits => {:apple => 'pie'} },nil)
    entity.fruits.apple.should eql('pie')
  end

  it "should be able to return a hash object" do
    entity = Taza::Entity.new({:apple => 'pie' },nil)
    entity.to_hash[:apple].should eql('pie')
  end

  it "should be able to do string-to-symbol conversion for hash keys using to_hash" do
    entity = Taza::Entity.new({'apple' => 'pie' },nil)
    entity.to_hash[:apple].should eql('pie')
  end

  it "should be able to do string-to-symbol conversion for hash keys" do
    entity = Taza::Entity.new({'fruits' => {'apple' => 'pie' }},nil)
    entity.to_hash[:fruits][:apple].should eql('pie')
  end

end
