module Taza
  # An abstraction of a web page, place the elements you care about accessing in here as well as specify the filters that apply when trying to access the element.
  #
  # Example:
  #   require 'taza'
  #   class HomePage < Taza::Page
  #     element(:foo) {browser.element_by_xpath('some xpath')}
  #     filter :title_given, :foo
  #
  #     def title_given
  #       browser.title.nil?
  #     end
  #   end
  #
  # homepage.foo will return the element specified in the block if the filter returned true
  class Page
    attr_accessor :browser
    class << self
      def elements # :nodoc:
        @elements ||= {}
      end
      def filters # :nodoc:
        @filters ||= Hash.new { [] }
      end
    end

    # A element on a page
    #
    # Watir Example:
    #   class HomePage < Taza::Page
    #     element(:foo) {browser.element_by_xpath('some xpath')}
    #   end
    # homepage.foo.click
    def self.element(name,&block)
      if !@module.nil?
        self.elements[@module] = Hash.new if self.elements[@module].nil?
        self.elements[@module] = self.elements[@module].merge({ name => block })
      else
        self.elements[name] = block
      end
    end

    # A filter for elemenet(s) on a page
    # Example:
    #   class HomePage < Taza::Page
    #     element(:foo) {browser.element_by_xpath('some xpath')}
    #     filter :title_given, :foo
    #     #a filter will apply to all elements if none are specified
    #     filter :some_filter
    #     #a filter will also apply to all elements if the symbol :all is given
    #     filter :another_filter, :all
    #
    #     def some_filter
    #       true
    #     end
    #
    #     def some_filter
    #       true
    #     end
    #
    #     def title_given
    #       browser.title.nil?
    #     end
    #   end
    def self.filter(method_name, *elements)
      elements = [:all] if elements.empty?
      elements.each do |element|
        self.filters[element] = self.filters[element] << method_name
      end
    end

    def self.page_module(name,&block)
      @module = name
      yield(block)
      @module = nil
    end

    def initialize(page_module = nil)
      add_element_methods(page_module)
      @active_filters = []
    end

    def add_element_methods(page_module = nil) # :nodoc:
      self.class.elements.each do |element_name,element_block|
        if (element_block.is_a?(Hash) && !page_module.nil? && page_module==element_name)
          element_block.each do |key,value|
            filters = self.class.filters[element_name] + self.class.filters[:all]
            add_element_method(:filters => filters, :element_name => key, :element_block => value)
          end
        else
          filters = self.class.filters[element_name] + self.class.filters[:all]
          add_element_method(:filters => filters, :element_name => element_name, :element_block => element_block)
        end
      end
    end

    def add_element_method(params) # :nodoc:
      metaclass.class_eval do
        define_method(params[:element_name]) do |*args|
          check_filters(params)
          self.instance_exec(*args,&params[:element_block])
        end
      end
    end

    def check_filters(params) # :nodoc:
      params[:filters].each do |filter_method|
        unless @active_filters.include?(filter_method)
          @active_filters << filter_method
          raise FilterError, "#{filter_method} returned false for #{params[:element_name]}" unless send(filter_method)
          @active_filters.delete(filter_method)
        end
      end
    end
  end

  class FilterError < StandardError; end
end
