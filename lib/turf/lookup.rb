module Turf; class Lookup

  def find(message)
    lookup_path.each do |obj|
      return obj.send(message) if obj.respond_to?(message)
    end
    raise "#{message} was not found in the Turf configuration files"
  end

  def lookup_path
    p = [env_class.new, Default.new]
    p.unshift(Local.new) unless env == "test"
    p
  end

  def env_class
    "Turf::#{env.titlecase}".constantize
  end

  def env
    ENV['PROJECT_ENV'] ||= ENV['RAILS_ENV'] || 'development'
  end

end; end
