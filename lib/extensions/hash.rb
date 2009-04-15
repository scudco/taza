class Hash
  def convert_hash_keys_to_methods(fixture) # :nodoc:
    Taza::Entity.new(self,fixture)
  end

  # Recursively replace key names that should be symbols with symbols.
  def key_strings_to_symbols!
    result = Hash.new
    self.each_pair do |key,value|
      value.key_strings_to_symbols! if value.kind_of? Hash and value.respond_to? :key_strings_to_symbols!
      result[key.to_sym] = value
    end
    self.replace(result)
  end
end
