module HexagonalJsonApi
  class ServiceCommandExecutor

    attr_reader :service_class, :service_object, :response_class

    def initialize(service_class:, params:, response_class:, data_presenter_class: nil)
      self.service_class = service_class
      self.service_object = service_class.new(params)
      self.response_class = response_class
      self.data_presenter_class = data_presenter_class
    end

    def execute
      result_data = service_object.execute
      success_response(result_data)

    rescue *service_object.validation_error_classes => error
      handle_validation_error(error)

      return error_response(error_message: error_message(error))
    rescue StandardError => error
      handle_unexpected_error(error)

      return error_response(error: error)
    end

    def data_presenter_class
      return null_presenter_class unless @data_presenter_class.is_a?(Class)

      @data_presenter_class
    end

    def handle_validation_error(error)
      raise NotImplementedError
    end

    def handle_unexpected_error(error)
      raise NotImplementedError
    end

    def error_message(error)
      raise NotImplementedError
    end

    private

    attr_writer :service_class, :service_object, :response_class, :data_presenter_class

    def success_response(result_data)
      response_class.new(data: data_hash(result_data))
    end

    def error_response(error: nil, error_message: nil)
      response_class.new(error: error, error_message: error_message)
    end

    def data_hash(result_data)
      data_presenter_class.new(data: result_data).data_hash
    end

    def null_presenter_class
      Presenters::NullPresenter
    end
  end
end
