module Turf; class Lookup

  def find(message)
    if local_class && default_class
      m = "The following methods are defined in the #{local_class} class but not the #{default_class} class: #{methods_in_local_and_not_default.join(', ')}.  All methods defined in #{local_class} must also be defined in #{default_class}."
      raise m unless methods_in_local_and_not_default.empty?
    end
    lookup_path.each do |obj|
      return obj.send(message) if obj.respond_to?(message)
    end
    raise "No Turf classes found... these must be defined and required" if classes.empty?
    raise NoMethodError, "The #{message} method could not be found in any of these Turf configuration classes: #{classes.join(", ")}"
  end

  private

  def methods_in_local_and_not_default
    local_class.instance_methods(false) - default_class.instance_methods(false)
  end

  def lookup_path
    classes.map(&:new)
  end

  def classes
    [
      (local_class unless env == "test"),
      env_class,
      default_class
    ].compact
  end

  def local_class
    class_or_nil { Local }
  end

  def default_class
    class_or_nil { Default }
  end

  def env_class
    class_or_nil { Object.const_get("Turf::#{env.capitalize}") }
  end

  def class_or_nil(&block)
    begin(instance_eval(&block))
      instance_eval(&block)
    rescue NameError
    end
  end

  def env
    return Rails.env if defined?(Rails)
    raise "The RAILS_ENV environment variable must be set" unless ENV['RAILS_ENV']
    ENV['RAILS_ENV']
  end

end; end
