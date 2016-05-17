# coding: utf-8
require 'spec_helper'

describe Apress::Sources::Accessors do
  let(:test_source) do
    Class.new { extend Apress::Sources::Accessors }
  end

  it do
    %w(string integer boolean date array).each do |type|
      expect { test_source.send("value_as_#{type}", field: :f) }.to raise_error(Apress::Sources::Errors::NoAccessor)
    end
  end
end
