require_relative "spec_helper"
require 'codeine'


describe Codeine::Utility do
  before(:each) do
    module Foo
      module Bar
        class Baz

        end
      end
    end
  end

  describe "constant_path" do
    it "should return an array of constant values" do
      path = Codeine::Utility.constant_path("Foo")
      path[0].should == Foo
    end

    it "should return constant path in heirarchial order" do
      path = Codeine::Utility.constant_path(Foo::Bar::Baz)
      path.should == [Foo, Foo::Bar, Foo::Bar::Baz]
    end
  end

  describe "nearest_container" do

    it "should look up the constant heirarchy for a container" do
      Foo.send(:extend, Codeine::Injectable)
      Foo.send(:extend, Codeine::Containable)
      Foo::Bar.send(:extend, Codeine::Injectable)
      Foo.codeine_container = "foo_container"
      Foo::Bar.nearest_codeine_container.should == "foo_container"
    end

    it "should not look down the constant heirarchy for a container" do
      Foo.send(:extend, Codeine::Injectable)
      Foo.send(:extend, Codeine::Containable)
      Foo::Bar.send(:extend, Codeine::Injectable)
      Foo::Bar.send(:extend, Codeine::Containable)

      Foo::Bar.codeine_container = "bar_container"
      Foo.nearest_codeine_container.should_not == "bar_container"
    end
  end
end
