require 'spec_helper'

class Turf::Test
  def something
    "something in test"
  end

  def blah
    "blah in test"
  end
end

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

module Turf; describe Lookup do

  context "#find" do
    it "skips locals in the test environment" do
      m = Lookup.new
      expect(m.find(:something)).to eq "something in test"
    end

    it "doesn't skip local in the development environment" do
      ENV['RAILS_ENV'] = "development"
      m = Lookup.new
      expect(m.find(:something)).to eq "something in local"
      ENV['RAILS_ENV'] = "test"
    end

    it "looks in env second" do
      m = Lookup.new
      expect(m.find(:blah)).to eq "blah in test"
    end

    it "works when Default isn't defined" do
      m = Lookup.new
      expect(m.find(:blah)).to eq "blah in test"
    end

    it "raises an exception when a method cannot be found" do
      m = Lookup.new
      message = "The hi_there method could not be found in any of these Turf configuration classes: Turf::Test"
      expect {m.find(:hi_there)}.to raise_error(message)
    end

    it "raises an exception when no classes are found" do
      m = Lookup.new
      allow(m).to receive(:classes).and_return([])
      message = "No Turf classes found... these must be defined and required"
      expect {m.find(:hi_there)}.to raise_error(message)
    end
  end

  context "#classes" do
    it "returns a list of the classes for the method lookup" do
      ENV['RAILS_ENV'] = "development"
      m = Lookup.new
      expect(m.send(:classes)).to eq [Turf::Local, Turf::Development]
      ENV['RAILS_ENV'] = "test"
    end
  end

  context "#env" do
    it "gets the environment" do
      m = Lookup.new
      expect(m.send(:env)).to eq "test"
    end
  end

end; end
