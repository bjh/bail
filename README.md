# Bail

#### What
A miniscule DSL to write guard clauses. Also to ask some basic questions of my types when I get curious.

#### Why
I was finding my methods were collecting a top layer of IF/ELSE statements that got harder to read and maintain.

#### How
Sweet sexy voodoo magic.

***

A basic *un-sugared* guard looks something like this:
```ruby
  Bail.when(:any, :of, :these, :things) {|item| item.nil?}
```

So you pass in an enumerator (defaults are the Enumerable module methods), any number of arguments, and a `block` for the condition test.

Super *easy* and super *cheezy*.

There are more specialized versions that do not require a block:  
These are really just lightly *sugared* wrappers around Enumerable methods...

```ruby
  Bail.when_any(condition, *objects)
  Bail.when_all(condition, *objects)
  Bail.when_one(condition, *objects)
  Bail.when_none(condition, *objects)
```

#### Why would you care?
To understand the **why** of this gem you can ask yourself this question:  
Do I prefer to read this:
```ruby
  [:one, :of, :these, :things].any? {|x| nil?}
```
or this:
```ruby
  Bail.when_any(:nil, :one, :of, :these, :things)
```

to be honest I would prefer a fluid approach:
```ruby
  Bail.when_any(:one, :of, :these, :things).are(:nil)
```

let's call that version 2.


#### Example Usage

Bail will usually live at the top of your methods.

```ruby
  # Assuming that Bail.raise_on_error = false
  def some_method(that, takes, arguments)
    return if Bail.when(:nil, that, takes, arguments)
    return if Bail.when_none({:is_a, String}, that, takes, arguments)

    # I will use it for type discovery instead of blindly asking it to quack
    # i.e. I know I want the takes variable to be an Integer but I get it as a String sometimes...
    if Bail.when_any({:is_a: String}, takes)
      Logger.debug("you are passing in `takes` to `some_method` as a String from somewhere...")
      takes = takes.to_i
    end
  end
```

## Installation

Add this line to your application's Gemfile:

    gem 'bail'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bail

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( http://github.com/<my-github-username>/bail/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
