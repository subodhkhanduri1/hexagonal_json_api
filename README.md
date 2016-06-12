# HexagonalJsonApi

[![CircleCI](https://circleci.com/gh/subodhkhanduri1/hexagonal_json_api/tree/master.svg?style=shield)](https://circleci.com/gh/subodhkhanduri1/hexagonal_json_api/tree/master)

This is a very simple pattern for modeling Rails JSON API requests in different layers based on their different responsibilities:
* Use Case Services - Each service `executes` a single Controller action's work
* Validators - Services use one or more Validator objects to validate/authorize the request
* Presenters - Formats the result data returned by the Service execution
* Data Objects - Services encapsulate the result data in a single data object which can pass through the narrow interface between the Service and the Presenter.
* Responses - Encapsulates the final response to give back to the Controller

The app's business logic can be further abstracted out into logic classes that are invoked by the Services.
 
### Benefits:
* Each layer is segregated and can be tested independently.
* Narrow, Hardened interfaces between the different layers.
* Service and Presenter combinations can be changed easily. 


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hexagonal_json_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hexagonal_json_api

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hexagonal_json_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

