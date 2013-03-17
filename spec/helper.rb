RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.color_enabled = true
  config.tty           = true
end

class Module
  def _set_internal_collaborator(role, collaborator)
    instance_variable_set("@#{role.to_s}", collaborator)
  end
end
