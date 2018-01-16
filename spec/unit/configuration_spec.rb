require 'spec_helper'

RSpec.describe InfluxDB::Rails::Configuration do
  before do
    @configuration = InfluxDB::Rails::Configuration.new
  end

  describe "#ignore_user_agent?" do
    it "should be true for user agents that have been set as ignorable" do
      @configuration.ignored_user_agents = %w{Googlebot}
      expect(@configuration.ignore_user_agent?("Googlebot/2.1")).to be_truthy
    end

    it "should be false for user agents that have not been set as ignorable" do
      @configuration.ignored_user_agents = %w{Googlebot}
      expect(@configuration.ignore_user_agent?("Mozilla/5.0")).to be_falsey
    end

    it "should be false if the ignored user agents list is empty" do
      @configuration.ignored_user_agents = []
      expect(@configuration.ignore_user_agent?("Googlebot/2.1")).to be_falsey
    end

    it "should be false if the ignored user agents list is inadvertently set to nil" do
      @configuration.ignored_user_agents = nil
      expect(@configuration.ignore_user_agent?("Googlebot/2.1")).to be_falsey
    end
  end

  describe "#retry" do
    it "defaults to nil" do
      InfluxDB::Rails.configure do |config|
      end
      expect(InfluxDB::Rails.configuration.retry).to be_nil
    end

    it "can be updated" do
      InfluxDB::Rails.configure do |config|
        config.retry = 5
      end
      expect(InfluxDB::Rails.configuration.retry).to eql(5)
    end
  end

  describe "#open_timeout" do
    it "defaults to 5" do
      InfluxDB::Rails.configure do |config|
      end
      expect(InfluxDB::Rails.configuration.open_timeout).to eql(5)
    end

    it "can be updated" do
      InfluxDB::Rails.configure do |config|
        config.open_timeout = 5
      end
      expect(InfluxDB::Rails.configuration.open_timeout).to eql(5)
    end
  end

  describe "#read_timeout" do
    it "defaults to 300" do
      InfluxDB::Rails.configure do |config|
      end
      expect(InfluxDB::Rails.configuration.read_timeout).to eql(300)
    end

    it "can be updated" do
      InfluxDB::Rails.configure do |config|
        config.read_timeout = 5
      end
      expect(InfluxDB::Rails.configuration.read_timeout).to eql(5)
    end
  end

  describe "#max_delay" do
    it "defaults to 30" do
      InfluxDB::Rails.configure do |config|
      end
      expect(InfluxDB::Rails.configuration.max_delay).to eql(30)
    end

    it "can be updated" do
      InfluxDB::Rails.configure do |config|
        config.max_delay = 5
      end
      expect(InfluxDB::Rails.configuration.max_delay).to eql(5)
    end
  end

  describe "#time_precision" do
    it "defaults to seconds" do
      InfluxDB::Rails.configure do |config|
      end
      expect(InfluxDB::Rails.configuration.time_precision).to eql('s')
    end

    it "can be updated" do
      InfluxDB::Rails.configure do |config|
        config.time_precision = 'ms'
      end
      expect(InfluxDB::Rails.configuration.time_precision).to eql('ms')
    end
  end
end
