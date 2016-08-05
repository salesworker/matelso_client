require 'matelso_client/configuration'
require 'matelso_client/version'

require 'matelso_client/api/client'
require 'matelso_client/version'

require 'savon'
require 'base64'

module MatelsoClient
  class << self
    attr_writer :configuration

    def api
      @client ||= API::Client.new
    end

    def configure(&block)
      api.configure(&block)
    end

    def configuration
      api.configuration
    end

    def root
      Gem::Specification.find_by_name("matelso_client").gem_dir
    end
  end
end

