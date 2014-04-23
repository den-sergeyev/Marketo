require_relative 'spec_helper'

describe Marketo do
  describe Marketo::Interface do
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
