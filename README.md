# AttrTrackable

Track attributes changes in AR models

## Installation

Add this line to your application's Gemfile:

    gem 'attr_trackable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attr_trackable

## Usage

For example if You want to track first_name and last_name attributes of Your model
```ruby
class Person < ActiveRecord::Base
  attr_trackable :first_name, :last_name
end
```

To fetch changes

```ruby
Person.changes_history :first_name
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
