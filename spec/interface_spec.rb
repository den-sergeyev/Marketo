require_relative 'spec_helper'
require "marketo"

describe Marketo do
  describe Marketo::Interface do
    IDNUM = 1000074
    EMAIL = "john@backupify.com"
    COOKIE = "id:572-ZRG-001&token:_mch-localhost-1306412206125-92040"
    USER = { :email => "john@backupify.com", :first_name => "john", :last_name => "kelly" }

    describe 'to_hash' do
      it 'should update timestamp on every call to avoid request expiration' do
        client = Marketo::Client.new_marketo_client

        first_timestamp = client.instance_variable_get(:@header).to_hash["requestTimestamp"]
        Timecop.freeze(Time.now + 10)
        second_timestamp = client.instance_variable_get(:@header).to_hash["requestTimestamp"]

        first_timestamp.should_not == second_timestamp

        Timecop.return
      end
    end
  end
end
