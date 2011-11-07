# instance_exec comes with >1.8.7 thankfully
class Object
  def metaclass
    class << self; self; end
  end
end
