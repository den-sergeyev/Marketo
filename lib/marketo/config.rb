module Marketo
  class Config
    def self.init
      @@config_file = Rails.root + "/config/marketo.yml"
    end

    def self.load
      self.init
      @@config_hash ||= begin
                          custom_params = File.open(@@config_file) do |f|
                            YAML::load(ERB.new(f.read).result)[Rails.env.to_s]
                          end
                          default_params.merge(custom_params)
                        end
    end

    def self.merge(other_params)
      result = self.load.clone
      other_params.each { |key, value| result[key.to_s] = value }
      result
    end

    private

    def self.default_params
      {
        "wsdl_document" => "https://app.marketo.com/soap/mktows/2_2?WSDL"
      }
    end
  end
end
