require "helper"

describe Awis::API::TrafficHistory do
  describe "parsing xml" do
    before do
      Awis.config do |c|
        c.access_key_id = 'key'
        c.secret_access_key = 'secret'
      end

      stub_request(:get, %r{http://awis.amazonaws.com}).to_return(fixture("traffic_history/github.txt"))
      @traffic_history = Awis::Client.new.traffic_history(:url => "github.com")
    end

    it "Should be has request id" do
      assert_equal "793668db-23a8-8438-2701-ed1c97c35cb8", @traffic_history.request_id
    end

    it "Should be has success status code" do
      assert_equal "Success", @traffic_history.status_code
    end

    it "Should be returns site" do
      assert_equal "github.com", @traffic_history.site
    end

    it "Should be returns range" do
      assert_equal 26, @traffic_history.range
    end

    it "Should be returns start" do
      assert_equal "2017-02-06", @traffic_history.start
    end

    it "Should be returns history datas" do
      assert_equal 21, @traffic_history.historical_data.size
    end
  end
end
