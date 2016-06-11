# Base Response class
#
# This can be used for simple GET responses.
#
# For custom responses, create derived classes and override the required methods.

module HexagonalJsonApi
  module Responses
    class Base

      attr_reader :data, :error, :error_message

      def initialize(data: nil, error: nil, error_message: nil)
        self.data = data || {}
        self.error = error
        self.error_message = error_message
      end

      def success?
        data.present? && error.blank? && error_message.blank?
      end

      def to_hash
        return success_response_hash if success?
        return error_response_hash if error.present?

        bad_request_response_hash
      end

      def success_status
        :ok
      end

      protected

      attr_writer :data, :error, :error_message

      def success_response_hash
        {
            json: {
                success: true,
            }.merge(data),
            status: success_status
        }
      end

      def bad_request_response_hash
        {
            json: {
                success: false,
                error: {
                    type: 'error',
                    message: error_message || 'Bad Request'
                }.merge(data)
            },
            status: :bad_request
        }
      end

      def error_response_hash
        {
            json: {
                success: false,
                error: {
                    type: 'error',
                    message: 'Something went wrong'
                }
            },
            status: :internal_server_error
        }
      end

    end
  end
end
