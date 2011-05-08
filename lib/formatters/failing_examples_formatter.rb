require 'rspec/core/formatters/documentation_formatter'

class FailingExamplesFormatter < RSpec::Core::Formatters::DocumentationFormatter

  def example_passed(example)
  end

end
