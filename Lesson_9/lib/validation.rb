module Validation

  class EmptyValue < StandardError; end
  class WrongFormat < StandardError; end
  class WrongType < StandardError; end

  def self.included(base)
    base.send :extend, ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    attr_reader :validation_rules

    def validate(name, type, *args)
      @validation_rules ||= []
      @validation_rules << { name: name, type: type, args: args }
    end
  end

  module InstanceMethods

    def valid?
      respond_to?("validate!") ? true : false
    end

    protected

    def validate!
      self.class.validation_rules.each do |rule|
        value = instance_variable_get("@#{rule[:name]}")
        send "validate_#{rule[:type]}", value, *rule[:args]
      end
    end

    def validate_presence(value)
      raise Validation::EmptyValue if value.nil? || value == ""
    end

    def validate_type(value, type)
      raise Validation::WrongType unless value.is_a?(type)
    end

    def validate_format(value, format)
      raise Validation::WrongFormat unless value =~ format
    end
  end

end
