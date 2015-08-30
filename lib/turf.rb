require "turf/version"

require_relative "./turf/lookup.rb"

module Turf

  class << self

    def find(message)
      m = Lookup.new
      m.find(message)
    end

    def method_missing(name, *args)
      find(name)
    end

  end

end
