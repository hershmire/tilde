require '<%= file_name %>'
$: << File.expand_path('../../lib', __FILE__)
$: << File.expand_path('../fixtures', __FILE__)

RSpec.configure do |config|
  # http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = :random
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# Allows testing true/false with `.is_a? Boolean`
#
module Boolean; end
class TrueClass; include Boolean; end
class FalseClass; include Boolean; end

# Allows getting/setting class variables
#
# Get
#   FooClass.class_var :foo_var
# Set
#   FooClass.class_var :foo_var, 'bar'
#
class Object
  def class_var class_var, value = nil
    if value
      self.send(:class_variable_set, :"@@#{class_var}", value)
    else
      self.send(:class_variable_get, :"@@#{class_var}")
    end
  end
end
