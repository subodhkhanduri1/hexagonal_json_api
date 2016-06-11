require 'spec_helper'

describe HexagonalJsonApi::Presenters::Base do

  let(:data) do
    {
      test: true
    }
  end

  let(:subject_class) { HexagonalJsonApi::Presenters::Base }

  subject { subject_class.new(data: data) }

  context '#initialize' do
    it 'sets params with the given params_hash' do
      expect(subject.data).to eq(data)
    end
  end

  context '#data_hash' do
    it 'raises NotImplementedError' do
      expect { subject.data_hash }.to raise_error(NotImplementedError)
    end
  end

  context '#data=' do
    it 'is a protected method' do
      expect(subject_class.protected_instance_methods(false)).to include(:data=)
      expect(subject_class.public_instance_methods).not_to include(:data=)
    end
  end
end
