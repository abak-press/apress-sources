# Apress::Sources

Add base source classes

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apress-sources'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apress-sources

## Usage

Create source class

```ruby
class SomeSource < Apress::Sources::Base
  # Now this class have accessors
  # create value methods like this:
  def value_as_string(params)
    # put here extraction value from params
  end
end
```

Or crate source class which must use cache

```ruby
class CacheSomeModel < Apress::Sources::CachedSources

  class << self
    # create init data method
    def init_data
    # for example hash of model attributes
    end

    # create value methods
    def value_as_string(params)
      data[params.fetch(:object)]
    end

    # also you can change cached time
    def cache_expires_in
      6.hours
    end
  end
end
```

Then you can take value where you want
```ruby
CacheSomeModel.value_as_string(object: current_object)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/abak-press/apress-sources.



