# Instance Counter
module InstanceCounter
  def self.included(base)
    base.send :extend, ClassMethods
    base.send :include, InstanceMethods
    base.instances = 0
  end

  module ClassMethods
    attr_accessor :instances
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances += 1
    end
  end
end
