require 'spec_helper'

describe HexagonalJsonApi::Services::Base do

  let(:params_hash) do
    {
      test: true
    }
  end

  let(:subject_class) { HexagonalJsonApi::Services::Base }

  subject { subject_class.new(params_hash) }

  context '#initialize' do
    it 'sets params with the given params_hash' do
      expect(subject.params).to eq(params_hash)
    end
  end

  context '#execute' do
    it 'raises NotImplementedError' do
      expect { subject.execute }.to raise_error(NotImplementedError)
    end
  end

  context '#validation_error_classes' do
    it 'raises NotImplementedError' do
      expect { subject.validation_error_classes }.to raise_error(NotImplementedError)
    end
  end

  context '#params=' do
    it 'is a protected method' do
      expect(subject_class.protected_instance_methods(false)).to include(:params=)
      expect(subject_class.public_instance_methods).not_to include(:params=)
    end
  end
end
