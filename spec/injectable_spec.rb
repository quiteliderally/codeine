
require_relative "spec_helper"
require 'codeine'


describe Codeine::Injectable do
  before(:each) do
    module Foo
      class Bar

      end


    end
  end
  let(:container){Codeine::Container.new}

  describe "dynamic methods" do
    it "should create a module-level codeine_inject method" do
      Foo::Bar.should respond_to(:codeine_inject)
    end

    it "should create a service getter for injected services" do
      Foo::Bar.codeine_container = container
      container.register(:bat){"man"}
      Foo::Bar.codeine_inject(:bat)
      bar = Foo::Bar.new
      bar.bat.should == "man"
    end

    it "should pass provided parameters to the registered block" do
      Foo::Bar.codeine_container = container
      container.register(:bat){|arg|
        "foo" + arg
      }
      Foo::Bar.codeine_inject(:bat)
      bar = Foo::Bar.new
      bar.bat("man").should == "fooman"
    end
  end

end
