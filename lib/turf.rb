require "turf/version"
require 'active_support/all'
require 'pry'

require_relative "./turf/lookup.rb"

module Turf
  def self.find(message)
    m = Lookup.new
    m.find(message)
  end
end
