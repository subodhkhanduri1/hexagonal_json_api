require 'spec_helper'

describe HexagonalJsonApi do
  it 'has a version number' do
    expect(HexagonalJsonApi::VERSION).not_to be(nil)
  end

  it 'version number is 0.1.0' do
    expect(HexagonalJsonApi::VERSION).to eq('0.1.0')
  end
end
