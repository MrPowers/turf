# Turf

Turf lets you control the value of variables in different environments and makes it easy to override values locally.  It's easy to set `speak_in_chat` to `true` when `RAILS_ENV` equals "production" and `false` otherwise.  Turf is similar to the Rails `secrets.yml` file, but more powerful because it can execute Ruby code and return arrays, hashes, etc.


## How it works

Turf looks for methods in the following order:

1. The `Turf::Local` class.
2. The `Turf::Test`, `Turf::Development`, or `Turf::Production` class.  Turf uses the development environment by default, but this can be overridden by setting `RAILS_ENV` to "production" or "test".
3. The `Turf::Default` class.

I recommend defining the Turf classes in the `/config/turf` directory.


## Examples

```ruby
ENV["RAILS_ENV"] = "production"

class Turf::Local
  def something
    "something in local"
  end
end

class Turf::Development
  def blah
    "blah in development"
  end
end

class Turf::Production
  def something
    "something in production"
  end

  def blah
    "blah in production"
  end
end

class Turf::Default
  def four
    2 + 2
  end
end

# Turf::Local is the first place Turf looks for a
# matching method
Turf.find(:something) # => "something in local"

# The RAILS_ENV is set to production, so Turf looks
# in Turf::Production second if the method is not
# found in Turf::Local
# Turf::Development is ignored in production
Turf.find(:blah) # => "blah in production"

# Turf::Default is the last place to look
Turf.find(:four) # => 4

# Turf raises an exception when it can't find
# a matching method
Turf.find(:hi_there) # => raises an exception
```

## Setup

Add this line to your application's Gemfile:

```ruby
gem 'turf'
```

Require turf:

```ruby
require 'turf'
```

Create the `Turf::Local`, `Turf::Test`, `Turf::Development`, `Turf::Production`, and `Turf::Default` classes (you don't have to create all of them, just the ones you want).

Use `Turf.find()` in your project.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MrPowers/turf.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
