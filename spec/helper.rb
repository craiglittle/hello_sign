require 'hello_sign'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.color_enabled = true
  config.tty           = true
  config.formatter     = :documentation
end
