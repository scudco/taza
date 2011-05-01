require 'active_support'
require 'taza/options'

module Taza
  class Settings
    #   Taza::Settings.Config('google')
    def self.config(site_name)
      site_file(site_name).merge(Options.new.execute)
    end

    # Loads the config file for the entire project and returns the hash.
    # Does not override settings from the ENV variables.
    def self.config_file
      YAML.load_file(config_file_path)
    end

    def self.config_file_path # :nodoc:
      File.join(config_folder,'config.yml')
    end
    
    def self.config_folder # :nodoc:
      File.join(path,'config')
    end
    
    def self.site_file(site_name) # :nodoc:
      YAML.load_file(File.join(config_folder,"#{site_name.underscore}.yml"))[ENV['TAZA_ENV']]
    end

    def self.path # :nodoc:
      '.'
    end
  end
end
