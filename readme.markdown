Codeine
=======

A simple dependency injector for ruby projects.

Despite how flexible ruby is, and despite the insistence of a large part of the community, I frequently run into the need on larger projects to centrally manage my dependencies.  I end up building something like Codeine for each one, so I decided to build it one more time and re-use it.

Usage
-----

Codeine can operate as either a global or module-local dependency container.  Using it globally is the least flexible, but presents the simplest syntax.

    require 'codeine'
    Codeine.register(:logger){Logger.new}

    class Foo
      codeine_inject :logger
      
      def initialize
        logger.log "Initialized..."
      end
    end


For library code, and for larger projects, it's probably a better idea to segregate the containers.

    require 'codeine'


    module ProjectA
      class Foo
        codeine_inject :logger

        def initialize
          logger.log "Initialized..."
        end
      end
    end

    container = Codeine.container_for(ProjectA)
    container.register(:logger){Logger.new}

    foo = ProjectA::Foo.new


The the container bound to the ProjectA module will only service injection requests from classes/modules that reside within it
