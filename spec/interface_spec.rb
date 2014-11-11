require_relative 'spec_helper'

describe Marketo do
  describe Marketo::Interface do
    let(:client) { Marketo::Client.new_marketo_client }

    describe 'to_hash' do
      it 'should update timestamp on every call to avoid request expiration' do

        first_timestamp = client.instance_variable_get(:@header).to_hash["requestTimestamp"]
        Timecop.freeze(Time.now + 10)
        second_timestamp = client.instance_variable_get(:@header).to_hash["requestTimestamp"]

        first_timestamp.should_not == second_timestamp

        Timecop.return
      end
    end

    describe 'normalize_response' do
      it 'should return array if response is array' do
        response = [{:lead => 12345, :status => 'UPDATED', :error => nil},
                    {:lead => 12346, :status => 'SKIPPED', :error => 'Not uniq'}]

        client.send(:normalize_response, response).should == response
      end

      it 'should return one element array if response is hash' do
        response = {:lead => 12345, :status => 'UPDATED', :error => nil}
        client.send(:normalize_response, response).should == [response]
      end
    end
  end
end
