require 'rubygems'
require 'rake'
require 'taglob/rake/tasks'
require 'spec/rake/spectask'

def tags
  ENV['TAGS']
end

module Taza
  module Rake
    class Tasks
      attr_accessor :spec_opts

      def initialize
        yield self if block_given?
        define
      end

      def define_spec_task(name,glob_path)
        Spec::Rake::SpecTask.new name do |t|
          t.spec_files = Dir.taglob(glob_path,tags)
          t.spec_opts << spec_opts
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
        define_spec_task(basename,File.join(dir,"**","*_spec.rb"))
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
