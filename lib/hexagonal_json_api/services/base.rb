# Abstract Base class for API Service Actions
#
# DO NOT:
# - initialize this class
# - add custom code to this class(this class must remain generic)
#
# Create and use classes derived from this class.
#
# Derived classes must implement:
# - execute instance method
# - validation_error_classes instance method: must return an
#     array of validation error classes

module HexagonalJsonApi
  module Services
    class Base

      attr_reader :params

      def initialize(params = nil)
        self.params = params || {}
      end

      def execute
        raise NotImplementedError
      end

      def validation_error_classes
        raise NotImplementedError
      end

      protected

      attr_writer :params

    end
  end
end
