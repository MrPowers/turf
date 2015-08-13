require 'spec_helper'

class Turf::Local
  def something
    "something in local"
  end
end

class Turf::Development
  def something
    "something in development"
  end

  def blah
    "blah in development"
  end
end

class Turf::Test
  def something
    "something in test"
  end

  def blah
    "blah in test"
  end
end

class Turf::Default
  def something
    "something in default"
  end

  def sah
    "sah in default"
  end
end

module Turf; describe Lookup do

  context "#find" do
    it "skips locals in the test environment" do
      m = Lookup.new
      expect(m.find(:something)).to eq "something in test"
    end

    it "doesn't skip local in the development environment" do
      ENV['PROJECT_ENV'] = "development"
      m = Lookup.new
      expect(m.find(:something)).to eq "something in local"
      ENV['PROJECT_ENV'] = "test"
    end

    it "looks in env second" do
      m = Lookup.new
      expect(m.find(:blah)).to eq "blah in test"
    end

    it "looks in default third" do
      m = Lookup.new
      expect(m.find(:sah)).to eq "sah in default"
    end
  end

  context "#env" do
    it "gets the environment" do
      m = Lookup.new
      expect(m.send(:env)).to eq "test"
    end
  end

end; end
