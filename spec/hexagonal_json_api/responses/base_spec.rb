require 'spec_helper'

describe HexagonalJsonApi::Responses::Base do

  let(:test_error_message) { 'test error message' }
  let(:test_error) { StandardError.new(test_error_message) }
  let(:test_data) do
    {
      test: true
    }
  end

  context '#initialize' do
    subject do
      HexagonalJsonApi::Responses::Base.new(
        data: test_data,
        error: test_error,
        error_message: test_error_message,
      )
    end

    it 'sets data with the given data' do
      expect(subject.data).to be(test_data)
    end

    it 'sets error with the given error object' do
      expect(subject.error).to be(test_error)
    end

    it 'sets error_message with the given error_message' do
      expect(subject.error_message).to be(test_error_message)
    end
  end

  context '#to_hash' do
    context 'when data is present, and error and error_message are blank' do
      subject do
        HexagonalJsonApi::Responses::Base.new(
          data: test_data
        )
      end

      let(:test_success_response_hash) do
        {
          json: {
            success: true,
          }.merge(test_data),
          status: :ok
        }
      end

      it 'returns success response hash' do
        expect(subject.to_hash).to eq(test_success_response_hash)
      end
    end

    context 'when error is given' do
      subject do
        HexagonalJsonApi::Responses::Base.new(
          error: test_error
        )
      end

      let(:test_error_response_hash) do
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

      it 'returns error response hash' do
        expect(subject.to_hash).to eq(test_error_response_hash)
      end
    end

    context 'when error_message is given' do
      subject do
        HexagonalJsonApi::Responses::Base.new(
          error_message: test_error_message
        )
      end

      let(:test_bad_request_response_hash) do
        {
          json: {
            success: false,
            error: {
              type: 'error',
              message: test_error_message
            }
          },
          status: :bad_request
        }
      end

      it 'returns error response hash' do
        expect(subject.to_hash).to eq(test_bad_request_response_hash)
      end
    end
  end

  context '#success?' do
    context 'when data is present, and error and error_message are blank' do
      subject do
        HexagonalJsonApi::Responses::Base.new(
          data: test_data
        )
      end

      it 'returns true' do
        expect(subject.success?).to be(true)
      end
    end

    context 'when data given is blank' do
      subject do
        HexagonalJsonApi::Responses::Base.new(
          data: {}
        )
      end

      it 'returns false' do
        expect(subject.success?).to be(false)
      end
    end

    context 'when error is given' do
      subject do
        HexagonalJsonApi::Responses::Base.new(
          error: test_error
        )
      end

      it 'returns false' do
        expect(subject.success?).to be(false)
      end
    end

    context 'when error_message is given' do
      subject do
        HexagonalJsonApi::Responses::Base.new(
          error_message: test_error_message
        )
      end

      it 'returns false' do
        expect(subject.success?).to be(false)
      end
    end
  end

  context '#success_status' do
    it 'returns :ok' do
      expect(subject.success_status).to be(:ok)
    end
  end

  context '#data=' do
    it 'is a protected method' do
      expect(subject.class.protected_instance_methods(false)).to include(:data=)
      expect(subject.class.public_instance_methods).not_to include(:data=)
    end
  end

  context '#error=' do
    it 'is a protected method' do
      expect(subject.class.protected_instance_methods(false)).to include(:error=)
      expect(subject.class.public_instance_methods).not_to include(:error=)
    end
  end

  context '#error_message=' do
    it 'is a protected method' do
      expect(subject.class.protected_instance_methods(false)).to include(:error_message=)
      expect(subject.class.public_instance_methods).not_to include(:error_message=)
    end
  end
end
