# Abstract Base class for API Data Presenters
#
# DO NOT:
# - initialize this class
# - add custom code to this class(this class must remain generic)
#
# Create and use classes derived from this class.
#
# Derived classes must implement:
# - data_hash instance method

module HexagonalJsonApi
  module Presenters
    class Base

      attr_reader :data

      def initialize(data: nil)
        self.data = data
      end

      def data_hash
        raise NotImplementedError
      end

      protected

      attr_writer :data
    end
  end
end
