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
Turf.something # => "something in local"

# The RAILS_ENV is set to production, so Turf looks
# in Turf::Production second if the method is not
# found in Turf::Local
# Turf::Development is ignored in production
Turf.blah # => "blah in production"

# Turf::Default is the last place to look
Turf.four # => 4

# Turf raises an exception when it can't find
# a matching method
Turf.hi_there # => raises an exception
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

## Suggested Setup

Include the Turf setup rake task in your project's `Rakefile`:

```ruby
load "tasks/setup.rake"
```

Run the rake task to create the classes in your project:

```
bundle exec rake turf:setup
```

### Ruby Projects (see below for Rails Projects)

Require all the files in the `/lib/#{project_name}.rb` file:

```ruby
require_relative "../config/turf/default.rb"

def require_all(pattern)
  Dir.glob("#{Turf.root}/#{pattern}/**/*.rb").sort.each { |path| require path }
end

require_all("config/turf")
```

***RAILS_ENV is used to manage the environment for compatibility with other gems***

Set the `RAILS_ENV` to "develoment" at the top of the `/lib/#{project_name}.rb` file:

```ruby
ENV['RAILS_ENV'] ||= "development"
```

Set the `RAILS_ENV` to "test" in the `spec_helper.rb` file:

```ruby
ENV['RAILS_ENV'] = 'test'
```

Set the `RAILS_ENV` to production on the remote host.

### Rails Projects

Require all the `Turf` files in the `config/application.rb` file:

```ruby
Dir.glob("#{Rails.root}/config/turf/**/*.rb").each { |path| require path }
```

That's it!

## .gitignore Turf::Local

Application secrets can be stored in `Turf::Local` and the file can be gitignored so these secrets are not exposed in source control.  Add this line (`/config/turf/local.rb`) to your `.gitignore` file and `scp` the local.rb file to the remote host when changes are made.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MrPowers/turf.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
