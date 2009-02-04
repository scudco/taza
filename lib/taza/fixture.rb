require 'find'
require "erb"

module Taza
  class Fixture # :nodoc:

    def initialize # :nodoc:
      @fixtures = {}
    end

    def load_all(fixtures_pattern) # :nodoc:
      index_of_fixtures = fixtures_pattern.index("fixtures")
      truncated_pattern = fixtures_pattern[index_of_fixtures..-1]
      Dir.glob(File.join(base_path,truncated_pattern)) do |file|
        templatized_fixture=ERB.new(File.read(file))
        entitized_fixture = {}
        YAML.load(templatized_fixture.result()).each do |key, value|
          entitized_fixture[key] = value.convert_hash_keys_to_methods(self)
        end
        @fixtures[File.basename(file,'.yml').to_sym] = entitized_fixture
      end
    end
    
    def fixture_names # :nodoc:
      @fixtures.keys
    end

    def get_fixture(fixture_file_key)
      @fixtures[fixture_file_key]
    end  
    
    def get_fixture_entity(fixture_file_key,entity_key) # :nodoc:
      @fixtures[fixture_file_key][entity_key]
    end

    def pluralized_fixture_exists?(singularized_fixture_name) # :nodoc:
      fixture_exists?(singularized_fixture_name.pluralize_to_sym)
    end
    
    def specific_fixture_entities(fixture_key, select_array)
      cloned_fixture = @fixtures[fixture_key].clone
      cloned_fixture.delete_if {|key , value| !select_array.include?(key)}
    end

    def fixture_exists?(fixture_name)
      fixture_names.include?(fixture_name.to_sym)
    end

   def base_path # :nodoc:
     File.join('.','spec')
   end
  end
  
  # The module that will mixin methods based on the fixture files in your 'spec/fixtures'
  # 
  # Example:
  #   describe "something" do
  #     it "should test something" do
  #       users(:jane_smith).first_name.should eql("jane")
  #     end
  #   end
  # 
  #  where there is a spec/fixtures/users.yml file containing a entry of:
  # jane_smith:
  #   first_name: jane
  #   last_name: smith
    dirs = Dir.glob(File.join(Fixture.new.base_path,"**","**")).select {|d| File.directory?(d) }
    dirs[0,0] = File.join(Fixture.new.base_path,"fixtures")
    dirs.each do |mod|
      base_module = mod == dirs[0] ? "" : "Fixtures::"
      self.class_eval <<-EOS
      module #{base_module}#{mod.split('/')[-1].camelize}
        def self.included(other_module) 
          fixture = Fixture.new
          fixture.load_all(File.join("#{mod}","*.yml"))
          fixture.fixture_names.each do |fixture_name|
            self.class_eval do
              define_method(fixture_name) do |entity_key|
                fixture.get_fixture_entity(fixture_name,entity_key.to_s)
              end
            end
          end
        end
      end
      EOS
   end
end

