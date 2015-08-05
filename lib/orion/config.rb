# -*- encoding : utf-8 -*-
module Orion
  module Config

    class << self
      attr_reader :orion_url

      def load_config(orion_url)
        begin
          filename = "/config/initializers/fiware_orion_config.rb"
          # filename = "#{Rails.root}/config/initializers/fiware_orion_config.rb"
          if self.check_config_file(filename)
            require filename
            @orion_url = (orion_url.nil?) ? QQ_CONNECT_API_KEY : orion_url
          else
            @orion_url = orion_url
            puts @orion_url
          end
          {
              orion_url: @orion_url,
          }
        rescue => e
          puts e => e.message
        end
      end

      def check_config_file(filename)
        result = true
        unless File.exist?(filename)
          puts "|>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
          puts "|"
          puts "Please configure orion_url in #{filename}."
          puts "|"
          puts "|>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
          result = false
        end
        result
      end
    end


  end
end