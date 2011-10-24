
require_relative "spec_helper"
require 'codeine'


describe Codeine::Injectable do
  before(:each) do
    module Foo
      class Bar

      end


    end
  end

  describe "dynamic methods" do
    it "should create a module-level codeine_inject method" do
      Foo::Bar.should respond_to(:codeine_inject)
    end

    it "should create a service getter for injected services" do
      Foo::Bar.codeine_container = {:bat => "man"}
      Foo::Bar.codeine_inject(:bat)
      bar = Foo::Bar.new
      bar.bat.should == "man"
    end
  end

end
