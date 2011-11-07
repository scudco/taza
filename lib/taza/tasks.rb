require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'

module Taza
  module Rake
    class Tasks
      attr_accessor :spec_opts

      def initialize
        yield self if block_given?
        define
      end

      def define_spec_task(name,glob_path)
        RSpec::Core::RakeTask.new name do |t|
          t.pattern = Dir.glob(glob_path)
          t.rspec_opts = spec_opts
        end
      end

      def define
        namespace :spec do
          Dir.glob('./spec/*/').each do |dir|
            recurse_to_create_rake_tasks(dir)
          end
        end
      end

      def recurse_to_create_rake_tasks(dir)
        basename = File.basename(dir)
        spec_pattern = File.join(dir,"**","*_spec.rb")
        if (not Dir.glob(spec_pattern).empty?)
          define_spec_task(basename,spec_pattern)
          namespace basename do
            Dir.glob(File.join(dir,"*_spec.rb")).each do |spec_file|
              spec_name = File.basename(spec_file,'_spec.rb')
              define_spec_task(spec_name,spec_file)
            end
            Dir.glob(File.join(dir,"*/")).each do |sub_dir|
              recurse_to_create_rake_tasks(sub_dir)
            end
          end
        end
      end

    end
  end
end
