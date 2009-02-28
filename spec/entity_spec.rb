require 'spec/spec_helper'
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

end
