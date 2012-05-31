<sub>This is a response for one of our apprentices who wanted to learn more about how structs work.</sub>

TL;DR
-----

Part of this is a response and part of it a challenge. If you are only interested in the challenge clone the repo and run rake (more detailed instructions [here](https://gist.github.com/2641441#challenge)).

Introduction
------------

I use `Struct` in a couple of ways. Doing a quick grep of directories that have made it onto this new computer, there are a couple of ways I use it.

As a superclass
---------------

Examples: [1](https://github.com/JoshCheek/surrogate/blob/d8c41f06743fa79adde0af7fc599813948cc87a6/lib/surrogate/rspec/api_method_matchers.rb#L71),
          [2](https://github.com/JoshCheek/surrogate/blob/d8c41f06743fa79adde0af7fc599813948cc87a6/lib/surrogate/api_comparer.rb#L53),
          [3](https://github.com/JoshCheek/surrogate/blob/d8c41f06743fa79adde0af7fc599813948cc87a6/lib/surrogate/api_comparer.rb#L84)

These are from my gem Surrogate, which helps with hand-rolled mocking. Since `Struct.new` returns a class, I can inherit from it.
Whatever names I pass to `Struct.new` will become methods that my instances can access. It also defines an initializer for me if I want to use it.
Note that it is important to use the setters and getters when doing this, rather than instance variables.
This is a point I explicitly (and, admittedly, rantilly) make one of my other gems, Deject [fourth paragraph](https://github.com/JoshCheek/deject/blob/d781cf016cf0d0ebb17a0997d8899f6ff4d1581e/Readme.md#about-the-code).
Also notice that I've done this several times in Deject's readme examples.

I usually use this approach to quickly scaffold out a simple class. Usually so simple that it's more of a data structure than an object.
Meaning its purpose is to hold values rather than encapsulate behaviour -- in general, objects should not have setters,
because it means you are taking their values and doing things with them or to them, but objects should be declarative interfaces that you interact with,
not holders of values that you set and get. When these mix, you wind up with a code smell called "feature envy". For more on this, there's a decent blog called "tell, don't ask".


As a simple class
-----------------

Similar to the above, but here the struct becomes the class itself (no need to inherit).

Examples: [1](https://github.com/JoshCheek/Play/blob/master/craigslist-watcher/craigslist_watcher.rb#L16),
          [2](https://github.com/JoshCheek/Play/blob/master/project_euler/lib/project_euler/problems/014.rb#L4)

In these two, it is just a quick way to get a class with methods I can access. Notice I set them into constants so that they feel very similar to "normal" classes.


As a class with behaviour
-------------------------

A bit less common (as soon as these become decently complex, I move them into "real" classes, they usually serve just to prototype out the idea).
But you can pass a block to `Struct.new`, and define any methods you want inside of there.
The block gets class evaled, so methods you define in there will be available on instances of the struct.
For simple object/data structures, this can be convenient, but these usually do still wind up turning into real classes pretty quickly.

Example: [1](https://github.com/JoshCheek/Play/blob/master/ruby-golf/helper.rb#L2-7)


Challenge
---------

I often feel that the best way to learn about something is to try and implement it (or a scaled down version of it) yourself.
If you'd like to try that, I included a spec for you which tests quite a bit of Struct's behaviour. You can implement your own
in order to learn about the one provided by Ruby.

To try it out:

    $ git clone git://gist.github.com/2641441.git
    $ cd 2641441
    $ rake

Then edit `lib/my_struct.rb` and run rake until there are no more failures. I've set it up to stop testing after the first failure,
so you can hopefully get a nice tdd style flow going.

Unfortunately most of the difficult things are right at the beginning, then it's smooth sailing after that. So don't give up, if you can get past the first several,
you'll be in a good place to tackle the rest of them. If you decide to do it, you'll have to learn some "metaprogramming".
I went through it myself to see what kinds of things I needed to do, so here are some pointers and tools to help you along the way.


Poointers and tools
-------------------

`SomeClass.new` is just a method, you can define it yourself if you want it to behave differently.

Classes are instances of [Class](http://rdoc.info/stdlib/core/1.9.3/Class), you can get one by typing `Class.new`. In general `class MyClass; end` is the same as `MyClass = Class.new(Object)`

When you instantiate `Class`, you can pass a block that will be [`class_eval`ed](http://rdoc.info/stdlib/core/1.9.3/Module#class_eval-instance_method).
The examples all show strings being passed in, but don't do that, use the block form like this:

```ruby
klass = Class.new { def hello() "world" end }
klass.new.hello # => "world"
```

Within a class context, you can say `define_method(:name) { 'Josh' }` and it will define for you an instance method called `name`,
which will return the string `'Josh'` when invoked.

Because these take blocks, they have access to variables defined in their enclosing environment:

```ruby
target = "world" # note that this var must be defined before the block

greet_class = Class.new do
  define_method :hello do
    target
  end
end

greeter = greet_class.new
greeter.hello # => "world"

target = "universe"
greeter.hello # => "universe"
```

The method `Hash.[]` will turn arrays of associated objects into key/value pairs in a hash.

```ruby
key_value_pairs = [[:name1, :value1], [:name2, :value2]]
Hash[key_value_pairs] # => {:name1=>:value1, :name2=>:value2}
```

You can get the block out of a method list with the ampersand `def meth(arg, &block)`

You can put an arg into the block slot of a method with the ampersand

```ruby
largest_first = lambda { |a, b| b <=> a }
[2,3,7,3,5,1,6,0].sort &largest_first # => [7, 6, 5, 3, 3, 2, 1, 0]
```


In Closing
----------

I hope you have fun with this challenge, if you finish it, I'll send you my solution.
Feel free to ask me any questions you have if you get stuck. Or, if you're pairing with Michael,
you can ask him as well.

"Metaprogramming" (which is really just programming -- and the conventional way of thinking about programming in Ruby,
with `class` and `def` and so forth is the real metaprogramming, that shit is crazy when you think about
what it's actually doing) is a lot of fun, but don't let it get away from you :)
It can often be difficult for people to reason about, so have mercy on your team and use it with discretion.
In general, I rarely use it outside of gems, and only for very straightforward uses within my apps.
