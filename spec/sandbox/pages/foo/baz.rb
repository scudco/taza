class Baz < Taza::Page
  page_module :module do
    element(:some_element) { :some_element_value }
    element(:other_element) { :other_element_value }
  end

  filter :boo, :module
  def boo
    true
  end
end
