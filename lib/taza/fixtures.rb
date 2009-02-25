require 'taza/fixture'

module Taza
  dirs = Dir.glob(File.join(Fixture.base_path,'*/'))
  dirs.unshift Fixture.base_path
  dirs.each do |dir|
    mod = dir.sub(Fixture.base_path,File.join(File.basename(Fixture.base_path),'')).camelize.sub(/::$/,'')
    self.class_eval <<-EOS
      module #{mod}
        def self.included(other_module) 
          fixture = Fixture.new
          fixture.load_fixtures_from('#{dir}')
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
