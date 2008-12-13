module Taza
  class Fixture
    attr_reader :name
    attr_reader :entities

    def self.fixtures_pattern
      File.join(base_path, 'fixtures','*.yml')
    end

    def self.base_path
      File.join('.','spec')
    end

    def self.load_all
      fixtures = []
      Dir.glob(self.fixtures_pattern) do |file|
        fixtures << self.load_file(file)
      end
      fixtures
    end

    def self.load_file(file_name)
      entities = {}
      YAML.load_file(file_name).each do |key, value|
        entities[key] = value.convert_hash_keys_to_methods(self)
      end
      Fixture.new(File.basename(file_name,'.yml'),entities)
    end

    def initialize(name,entities)
      @name = name
      @entities = entities
    end

    def entity(name)
      entities[name]
    end
  end
  
  module Fixtures
    def Fixtures.included(other_module)
      Fixture.load_all.each do |fixture|
        self.class_eval do
          define_method(fixture.name) do |entity_name|
            fixture.entity(entity_name.to_s)
          end
        end
      end
    end
  end

end
