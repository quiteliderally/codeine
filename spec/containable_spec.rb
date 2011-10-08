require_relative "spec_helper"
require 'codeine'


describe Codeine::Containable do
  before(:each) do
    module Foo
      class Bar
      end
    end
  end

  it "should create getter/setter" do
    Foo.send(:extend, Codeine::Containable)
    Foo.should respond_to :codeine_container
    Foo.should respond_to :codeine_container=
  end

  it "should store container at the instance level" do
    Foo.send(:extend, Codeine::Containable)
    Foo::Bar.send(:extend, Codeine::Containable)
  
    Foo.codeine_container = "foo_container"
    Foo::Bar.codeine_container = "bar_container"

    Foo.codeine_container.should == "foo_container"
    Foo::Bar.codeine_container.should == "bar_container"
  end


end
