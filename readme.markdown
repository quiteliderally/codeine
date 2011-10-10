Codeine
=======

A simple dependency injector for ruby projects.

Despite how flexible ruby is, and the insistence of [some seriously smart people](http://weblog.jamisbuck.org/2008/11/9/legos-play-doh-and-programming), I frequently run into the need on larger projects to centrally manage my dependencies.  I end up building something like Codeine for each one, so I decided to build it one more time and re-use it.

It turns out I agree with basically [everything Alexey Petrushin wrote here](http://ruby-lang.info/blog/you-underestimate-the-power-of-ioc-3fh)


Usage
-----

Codeine can operate as either a global or module-local dependency container.  Using it globally is the least flexible, but presents the simplest syntax.

```ruby
require 'codeine'
Codeine.register(:logger){Logger.new}

class Foo
  codeine_inject :logger
  
  def initialize
    logger.log "Initialized..."
  end
end
```


For library code, and for larger projects, it's probably a better idea to segregate the containers.

```ruby
require 'codeine'


module ProjectA
  class Foo
    codeine_inject :logger

    def initialize
      logger.log "Initialized..."
    end
  end
end

Codeine.configure(ProjectA) do
  c.register(:logger){Logger.new}
end

foo = ProjectA::Foo.new
```

The container bound to the ProjectA module will only service injection requests from classes/modules that reside within it


