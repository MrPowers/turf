module Turf; class Default

  def env
    raise "The RAILS_ENV environment variable must be set" unless ENV['RAILS_ENV']
    ENV['RAILS_ENV']
  end

  def root
    @root ||= File.expand_path("../../", File.dirname(__FILE__))
  end

end; end
