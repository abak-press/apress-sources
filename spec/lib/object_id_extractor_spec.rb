require 'spec_helper'

RSpec.describe Apress::Sources::ObjectIdExtractor, '#call' do
  it { expect(described_class.new(:company).call(object: 1)).to eq 1 }
  it { expect(described_class.new(:company).call(object: '1')).to eq 1 }
  it { expect(described_class.new(:company).call(object: 0)).to eq 0 }
  it { expect(described_class.new(:company).call(object: {company_id: 1})).to eq 1 }
  it { expect(described_class.new(:company).call(object: {company: '1'})).to eq 1 }
  it { expect(described_class.new(:company).call(object: double(id: 1))).to eq 1 }
  it { expect { described_class.new(:company).call(object: {user_id: 1}) }.to raise_error }
  it { expect { described_class.new(:company).call(object: nil) }.to raise_error }
  it do
    object = -> { 2 }
    expect(described_class.new(:company).call(object: object)).to eq 2
    expect(described_class.new(:company).call(object: {company_id: object})).to eq 2
  end
end
