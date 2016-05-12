# coding: utf-8
require 'spec_helper'

describe Apress::Sources::Errors::SourceError do
  it { expect(described_class.new).to be_a_kind_of(StandardError) }
end

describe Apress::Sources::Errors::NoAccessor do
  let(:error) { described_class.new(Class, :type, 'params') }

  it { expect(error).to be_a_kind_of(Apress::Sources::Errors::SourceError) }
  it { expect(error).to be_a_kind_of(StandardError) }
end
