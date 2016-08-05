require 'savon'
require 'base64'

module MatelsoClient

  BaseUrl = "https://www.matelso.de/Partnerbereich"
  WsdlUrls = {
      :fax    => "#{BaseUrl}/Matelso_Click2Faxservice_v_1_0.asmx?WSDL",
      :call   => "#{BaseUrl}/Matelso_Call2callservice_v_4_0.asmx?WSDL",
      :vanity => "#{BaseUrl}/Matelso_Rufnummernservice_v2_0.asmx?WSDL",
      :mrs    => "#{BaseUrl}/Matelso_MRS_v_2_0.asmx?WSDL",
  }

  module API
    class Client

      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield configuration
      end

      def initialize(action)
        @client = Savon::Client.new(wsdl: wsdl_url_for(action))
      end

      def wsdl_url_for(action)
        getp(action, MatelsoClient::WsdlUrls)
      end

      def getp(name, opts)
        opts[name.to_sym] || opts[name.to_s]
      end

      def methods
        @client.operations
      end

      def subscriber(id)
        call(:show_subscriber, {'subscriber_id' => id})
      end

      def get_testrequest
        call(:get_testrequest)
      end

      def show_b_numbers
        call(:show_b_numbers)[:data][:b_number]
      end

      def apply_profile(c_number, b_number)
        call(:apply_profile, {'b_number' => b_number, 'c_number' => c_number})[:status]
      end

      private

      attr_accessor :client

      def call(method, params = {})
        @client.call(
            method,
            message: add_account_params(params)
        ).body.to_hash["#{method.to_s}_response".to_sym]["#{method.to_s}_result".to_sym][:item]
      end

      def add_account_params(params)
        params.merge({'partner_id' => config[:id], 'partner_password' => config[:password]})
      end

      def config
        @@config ||= load_config
      end

      def load_config
        {
            id: configuration.id,
            password: configuration.password
        }
      end
    end
  end
end
