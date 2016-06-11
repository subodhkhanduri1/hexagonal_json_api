require 'spec_helper'

describe HexagonalJsonApi::ServiceCommandExecutor do

  let(:params_hash) do
    {
      test: true
    }
  end

  let(:test_error_message) { 'test error message' }
  let(:test_validation_error_class) do
    Class.new(StandardError)
  end
  let(:test_validation_error) { test_validation_error_class.new(test_error_message) }
  let(:test_error) { StandardError.new(test_error_message)}

  let(:test_service_class) { double('HexagonalJsonApi::Services::TestClass') }
  let(:test_service_object) { double('HexagonalJsonApi::Services::TestObject') }

  let(:test_data_presenter_class) { double('HexagonalJsonApi::Presenters::TestClass') }
  let(:test_data_presenter_object) { double('HexagonalJsonApi::Presenters::TestObject') }

  let(:test_response_class) { double('HexagonalJsonApi::Responses::TestClass') }
  let(:test_response_object) { double('HexagonalJsonApi::Responses::TestObject') }
  let(:test_validation_error_response_object) { double('HexagonalJsonApi::Responses::TestValidationErrorObject') }
  let(:test_error_response_object) { double('HexagonalJsonApi::Responses::TestErrorObject') }

  let(:test_service_result_data) do
    {
      result: 'success'
    }
  end

  before do
    allow(test_service_class)
      .to receive(:new)
            .with(params_hash)
            .and_return(test_service_object)

    allow(test_data_presenter_class)
      .to receive(:new)
            .with(data: test_service_result_data)
            .and_return(test_data_presenter_object)

    allow(test_response_class)
      .to receive(:new)
            .with(data: test_service_result_data)
            .and_return(test_response_object)

    allow(test_response_class)
      .to receive(:new)
            .with(error: nil, error_message: test_error_message)
            .and_return(test_validation_error_response_object)

    allow(test_response_class)
      .to receive(:new)
            .with(error: test_error, error_message: nil)
            .and_return(test_error_response_object)

    allow(test_service_object)
      .to receive(:validation_error_classes)
            .and_return([test_validation_error_class])

    allow(test_validation_error).to receive(:message).and_return(test_error_message)
    allow(test_error).to receive(:message).and_return(test_error_message)
  end

  context '#initialize' do
    subject do
      HexagonalJsonApi::ServiceCommandExecutor.new(
        service_class: test_service_class,
        params: params_hash,
        response_class: test_response_class,
        data_presenter_class: test_data_presenter_class
      )
    end

    it 'sets service_object with a new instance of service_class' do
      expect(subject.service_object).to eq(test_service_object)
    end
  end

  context '#execute' do
    subject do
      HexagonalJsonApi::ServiceCommandExecutor.new(
        service_class: test_service_class,
        params: params_hash,
        response_class: test_response_class,
        data_presenter_class: test_data_presenter_class
      )
    end

    context 'when service executes successfully' do
      before do
        allow(test_service_object).to receive(:execute).and_return(test_service_result_data)
        allow(test_data_presenter_class).to receive(:is_a?).with(Class).and_return(true)
        allow(test_data_presenter_object).to receive(:data_hash).and_return(test_service_result_data)
      end

      it 'creates a new response object with the result data' do
        expect(test_response_class).to receive(:new).with(data: test_service_result_data)
        subject.execute
      end

      it 'returns the success response object' do
        response = subject.execute
        expect(response).to be(test_response_object)
      end
    end

    context 'when service raises validation error' do
      subject do
        HexagonalJsonApi::ServiceCommandExecutor.new(
          service_class: test_service_class,
          params: params_hash,
          response_class: test_response_class,
          data_presenter_class: test_data_presenter_class
        )
      end

      before do
        allow(test_service_object).to receive(:execute).and_raise(test_validation_error)
        allow(subject).to receive(:handle_validation_error)
        allow(subject).to(
            receive(:error_message).with(test_validation_error).and_return(test_error_message)
        )
      end

      it 'delegates error handling to #handle_validation_error' do
        expect(subject).to receive(:handle_validation_error).with(test_validation_error)
        subject.execute
      end

      it 'returns error response' do
        expect(test_response_class).to(
            receive(:new).with(error: nil, error_message: test_error_message)
        )
        response = subject.execute
        expect(response).to be(test_validation_error_response_object)
      end
    end

    context 'when service raises unexpected error' do
      subject do
        HexagonalJsonApi::ServiceCommandExecutor.new(
          service_class: test_service_class,
          params: params_hash,
          response_class: test_response_class,
          data_presenter_class: test_data_presenter_class
        )
      end

      before do
        allow(test_service_object).to receive(:execute).and_raise(test_error)
        allow(subject).to receive(:handle_unexpected_error)
      end

      it 'delegates error handling to #handle_unexpected_error' do
        expect(subject).to receive(:handle_unexpected_error).with(test_error)
        subject.execute
      end

      it 'returns error response' do
        expect(test_response_class).to receive(:new).with(error: test_error, error_message: nil)
        response = subject.execute
        expect(response).to be(test_error_response_object)
      end
    end
  end

  context '#data_presenter_class' do
    context 'when data_presenter_class is a Class' do
      before do
        allow(test_data_presenter_class).to receive(:is_a?).with(Class).and_return(true)
      end

      subject do
        HexagonalJsonApi::ServiceCommandExecutor.new(
          service_class: test_service_class,
          params: params_hash,
          response_class: test_response_class,
          data_presenter_class: test_data_presenter_class
        )
      end

      it 'returns the data_presenter_class' do
        expect(subject.data_presenter_class).to be(test_data_presenter_class)
      end
    end

    context 'when data_presenter_class is not a Class' do
      subject do
        HexagonalJsonApi::ServiceCommandExecutor.new(
          service_class: test_service_class,
          params: params_hash,
          response_class: test_response_class,
          data_presenter_class: nil
        )
      end

      it 'returns Presenters::NullPresenter' do
        expect(subject.data_presenter_class).to be(HexagonalJsonApi::Presenters::NullPresenter)
      end
    end
  end

  context '#handle_validation_error' do
    subject do
      HexagonalJsonApi::ServiceCommandExecutor.new(
          service_class: test_service_class,
          params: params_hash,
          response_class: test_response_class,
          data_presenter_class: nil
      )
    end

    it 'raises NotImplementedError' do
      expect { subject.handle_validation_error(test_validation_error) }.to raise_error(NotImplementedError)
    end
  end

  context '#handle_unexpected_error' do
    subject do
      HexagonalJsonApi::ServiceCommandExecutor.new(
          service_class: test_service_class,
          params: params_hash,
          response_class: test_response_class,
          data_presenter_class: nil
      )
    end

    it 'raises NotImplementedError' do
      expect { subject.handle_unexpected_error(test_validation_error) }.to raise_error(NotImplementedError)
    end
  end

  context '#error_message' do
    subject do
      HexagonalJsonApi::ServiceCommandExecutor.new(
          service_class: test_service_class,
          params: params_hash,
          response_class: test_response_class,
          data_presenter_class: nil
      )
    end

    it 'raises NotImplementedError' do
      expect { subject.error_message(test_validation_error) }.to raise_error(NotImplementedError)
    end
  end
end
