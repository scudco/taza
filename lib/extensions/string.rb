
class String
  # pluralizes a string and turns it into a symbol
  # Example:
  #  "apple".pluralize_to_sym    # => :apples
  def pluralize_to_sym
    self.pluralize.to_sym
  end
  
  # takes human readable words and 
  # turns it into ruby variable format
  # dash and spaces to underscore
  # and lowercases
  def variablize
    self.squeeze!(' ')
	self.gsub!(/\s+/,'_')
	self.gsub!('-', '_')
	self.squeeze!('_')
	self.downcase!
	self
  end
end