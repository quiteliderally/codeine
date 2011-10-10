
require_relative "spec_helper"
require 'codeine'

describe Codeine::Container do
  let(:container){Codeine::Container.new}
  
  describe "#register" do
    it "should accept a block and register it as a service" do
      hash = Hash.new
      container.register(:foo){hash}

      container.services[:foo].call.should == hash
    end
  end

  describe "#get" do
    it "should execute the block registered at the given key" do
      hash = Hash.new
      container.register(:foo){hash}

      container.get(:foo).should == hash
    end

    it "should be aliased to []" do
      hash = Hash.new
      container.register(:foo){hash}

      container[:foo].should == hash
    end
  end

  describe "#filter" do
    it "should fire the given block when a key matches the given filter" do
      hash = Hash.new
      container.register(:foo){hash}
      container.filter(/^foo/){|key, service|
        service[:bar] = "baz"
      }
      service = container.get(:foo)
      service[:bar].should == "baz"
    end

    it "shouldn't fire the given block when a key doesn't match the given filter" do
      hash = Hash.new
      container.register(:foo){hash}
      container.filter(/^bar/){|key, service|
        service[:bar] = "baz"
      }
      service = container.get(:foo)
      service[:bar].should_not == "baz"
    end
  end

  describe "#configure" do
    it "should accept a block and yield self" do
      container.configure do |c|
        c.register(:foo) {"bar"}  
      end
      container.get(:foo).should == "bar"
    end
  end

end
