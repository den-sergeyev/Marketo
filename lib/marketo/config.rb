module Marketo
  class Config < Struct.new(:access_key, :secret_key, :wsdl_endpoint, :wsdl_document)

    def self.default
      config = new
      config.wsdl_document = "https://app.marketo.com/soap/mktows/2_2?WSDL"
      config
    end

    def merge(other_params)
      other_params.each { |key, value| send("#{key}=".to_sym, value) }
    end
  end
end
