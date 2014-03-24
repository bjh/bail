# Bail

#### What
A miniscule DSL to allow me to write guard clauses.

#### Why
I was finding my methods were collecting a pile of IF/ELSE tests that got hard to read and maintain.

#### How
Voodoo magic.


***

A basic guard looks something like this: 
```
Bail.when(:any, :of, :these, :things) {|item| item.nil?}
```

So you pass in an enumerator (defaults are the Enumerable module methods)  
any number of items  
and a `block` for the condition test

Super *easy* and super *cheezy*.

There are more specialized versions as well that do not require a block:  
These are really just light wrappers around Enumerable methods...

```
Bail.when_any(condition, *objects)
Bail.when_all(condition, *objects)
Bail.when_one(condition, *objects)
Bail.when_none(condition, *objects)
```

#### Why would you care?
To understand the **why** of this gem you can ask yourself this question:  
Do I prefer to read this: `[:one, :of, :these, :things].any? {|x| nil?}`  
or this: `Bail.when_any(:nil, :one, :of, :these, :things)`

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
