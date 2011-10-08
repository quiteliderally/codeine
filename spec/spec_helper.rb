$LOAD_PATH.unshift "../lib"

RSpec.configure do |config|
  config.after(:each) do
    Object.send(:remove_const, :Foo) if Object.const_defined?(:Foo)
  end
end
