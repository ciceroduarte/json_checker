# JsonChecker

Compare and validate JSON files

[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/hyperium/hyper/master/LICENSE)
[![Build Status](https://travis-ci.org/ciceroduarte/json_checker.svg?branch=master)](https://travis-ci.org/ciceroduarte/json_checker)
[![Coverage Status](https://coveralls.io/repos/github/ciceroduarte/json_checker/badge.svg?branch=master)](https://coveralls.io/github/ciceroduarte/json_checker?branch=master)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json_checker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_checker

## Configuration file

```json
# json-config.json
{
    "files": [
        {
			"name": "JSON example",
			"remote-path": "http://private-8d36d-jsonchecker.apiary-mock.com/choices",
			"keys" : {
				"choice1": "Swift",
		    	"choice2": "C",
		    	"choice2": "Swift22",
		    	"choice3": "Objective-C",
		    	"choice6": "Java"
		    },
		    "compare-to": [
                {
                    "remote-path": "http://private-8d36d-jsonchecker.apiary-mock.com/choices2",
                    "name": "Choices"
                }
		    ]
		}
    ]
}
```

### Fields

* `files`: List of files to validation.
* `name`: Name of file to report.
* `path`: Local path to file.
* `remote-path`: Remote path to file.
* `keys`: Key/value to check.
* `compare-to`: List of files to compare

## Usage

Add `json-config.json` to your path and run `json_checker`
```sh
$ json_checker
```

## HTML Output

Output example [output.html](http://htmlpreview.github.io/?https://github.com/ciceroduarte/json_checker/blob/master/output.html)

![Screenshot0](https://raw.githubusercontent.com/ciceroduarte/json_checker/master/images/output.png)
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ciceroduarte/json_checker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
