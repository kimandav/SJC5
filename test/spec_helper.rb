require 'simplecov'
SimpleCov.start

RSpec.configure do |c|
  c.formatter = :documentation
  c.color = true
end

def fixture(f)
  File.new(File.join(fixture_path, f))
end
