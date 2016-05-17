# coding: utf-8
require 'spec_helper'

describe Apress::Sources::Base do
  it do
    expect(described_class).to respond_to(:value_as_string)
    expect(described_class).to respond_to(:value_as_integer)
    expect(described_class).to respond_to(:value_as_boolean)
    expect(described_class).to respond_to(:value_as_date)
    expect(described_class).to respond_to(:value_as_array)
  end
end
