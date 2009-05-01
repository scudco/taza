require 'user-choices'
module Taza
  class Options < UserChoices::Command
    include UserChoices

    def add_sources(builder)
#     builder.add_source(CommandLineSource, :usage, "Usage: ruby #{$0} [options] file1 [file2]")
      builder.add_source(EnvironmentSource, :mapping, {:browser => 'BROWSER', :driver => 'DRIVER', :attach => 'ATTACH', :timeout => 'TIMEOUT', :server_ip => 'SERVER_IP', :server_port => 'SERVER_PORT'})
      builder.add_source(YamlConfigFileSource, :from_complete_path, Settings.config_file_path)
    end

    def add_choices(builder)
     builder.add_choice(:browser, :type=>:string, :default=>'firefox')
     builder.add_choice(:driver, :type=>:string, :default=>'selenium')
     builder.add_choice(:attach, :type=>:boolean, :default=>false)
     builder.add_choice(:timeout, :type=>:string)
     builder.add_choice(:server_ip, :type=>:string)
     builder.add_choice(:server_port, :type=>:string)
    end

    def execute
      @user_choices
    end
  end
end
