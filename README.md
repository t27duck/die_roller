# DieRoll

`DieRoll` is a simple dice notation parser and roller written in pure Ruby.

The gem supports the basic `AdX` dice roll notation (ie "2d6" meaning "2 6-sided dice").

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

    $ bundle add die_roll

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install die_roll

## Usage

The main interface is through `DieRoll.roll` which takes a string containing only dice notation. Multiple dice may be defined deliminated by whitespace.

Examples:

```ruby
DieRoll.roll("2d8")
DieRoll.roll("2d8 4d6")
DieRoll.roll(" 2d4  3d8")
```

If no number of dice are given, 1 is assumed:

```ruby
DieRoll.roll("d6") # Same as entering "1d6"
```

If parsing the string fails, `DieRoll::ParseError` will be raised:

```sh
> DieRoll.roll("1d6 badinput")
=> Invalid input 'badinput' (DieRoll::ParseError)
```

At least 4 sides must be declared per die, else `DieRoll::DieSizeError` is raised:

```sh
> DieRoll.roll("3d3 1d6")
=>  Die size too small for '3d3' (DieRoll::DieSizeError)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/t27duck/die_roll.

Pull requests will only be accepted if they meet all the following criteria (ran by CI):

1. Tests pass. This can be verified with:

```
$ bundle exec rake test
```

2. Code must conform to the [RuboCop rules](https://github.com/rubocop/rubocop#readme). This can be verified with:

```
$ bundle exec rake rubocop
```

3. RBS type signatures (in `sig/die_roll.rbs`). This can be verified with:

```
$ bundle exec rake steep
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
