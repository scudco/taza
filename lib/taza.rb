require 'active_support/all'
require 'rspec'
require 'taza/page'
require 'taza/site'
require 'taza/browser'
require 'taza/settings'
require 'taza/flow'
require 'taza/entity'
require 'taza/fixtures'
require 'extensions/object'
require 'extensions/string'
require 'extensions/hash'
require 'extensions/array'
require 'formatters/failing_examples_formatter'

module ForwardInitialization
  module ClassMethods
    def new(*args,&block)
      const_get("#{name.split("::").last}").new(*args,&block)
    end
  end

  def self.included(klass)
    klass.extend(ClassMethods)
  end
end
