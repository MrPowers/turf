module Turf; class Lookup

  def find(message)
    lookup_path.each do |obj|
      return obj.send(message) if obj.respond_to?(message)
    end
    raise "The #{message} method could not be found in any of these Turf configuration classes: #{classes.join(", ")}"
  end

  private

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
    ENV['RAILS_ENV'] || 'development'
  end

end; end
