module Taza
  class Browser

    # Create a browser instance depending on configuration.  Configuration should be read in via Taza::Settings.config.
    #
    # Example:
    #     browser = Taza::Browser.create(Taza::Settings.config)
    #
    def self.create(params={})
      self.send("create_#{params[:driver]}".to_sym,params)
    end

    def self.browser_class(params)
      self.send("#{params[:driver]}_#{params[:browser]}".to_sym)
    end

    private

    def self.create_watir(params)
      method = "watir_#{params[:browser]}"
      raise BrowserUnsupportedError unless self.respond_to?(method)
      watir = self.send(method,params)
      watir
    end

    def self.create_watir_webdriver(params)
      require 'watir-webdriver'
      Watir::Browser.new(params[:browser])
    end

    def self.create_selenium(params)
      require 'selenium'
      Selenium::SeleniumDriver.new(params[:server_ip],params[:server_port],'*' + params[:browser].to_s,params[:timeout])
    end

    def self.watir_firefox(params)
      require 'firewatir'
      FireWatir::Firefox.new
    end

    def self.watir_safari(params)
      require 'safariwatir'
      Watir::Safari.new
    end

    def self.watir_ie(params)
      require 'watir'
      if params[:attach]
         browser = Watir::IE.find(:title, //)
      end
      browser || Watir::IE.new
    end
  end

  # We don't know how to create the browser you asked for
  class BrowserUnsupportedError < StandardError; end
end

