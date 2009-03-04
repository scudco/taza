class Baz < Taza::Page
  page_module :another_module do
    element(:some_element) { :another_some_element_value }
  end

  filter :bay, :another_module
  def bay
    true
  end
end
