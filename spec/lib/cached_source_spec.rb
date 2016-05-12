# coding: utf-8
require 'spec_helper'

describe Apress::Sources::CachedSource do
  let(:cache_key) { described_class.send(:cache_key) }
  let(:cache_options) { described_class.send(:cache_options) }

  it do
    expect(described_class).to respond_to(:value_as_string)
    expect(described_class).to respond_to(:value_as_integer)
    expect(described_class).to respond_to(:value_as_boolean)
    expect(described_class).to respond_to(:value_as_date)
    expect(described_class).to respond_to(:value_as_array)
  end

  describe '.init_data' do
    it { expect { described_class.send(:init_data) }.to raise_error('not implemented') }
  end

  describe '.cache_tag' do
    it { expect(described_class.send(:cache_tag)).to eq 'apress_sources_cached_source' }
  end

  describe '.cache_key' do
    it { expect(cache_key).to include(Digest::MD5.hexdigest('apress_sources_cached_source')) }
  end

  describe '.reset_cache!' do
    before do
      allow(described_class).to receive(:init_data).and_return('some_data')
      Rails.application.config.perform_caching_queries = true
      described_class.data
    end

    it do
      expect { described_class.reset_cache! }
        .to change { Rails.cache.fetch(cache_key, cache_options).present? }.to false
    end
  end

  describe '.data' do
    context 'when cache off' do
      before do
        allow(described_class).to receive(:init_data).and_return('some_data')
        Rails.application.config.perform_caching_queries = false
      end

      it do
        expect(Rails.cache).to_not receive(:fetch)
        expect(described_class.data).to eq 'some_data'
      end
    end

    context 'when cache on' do
      before { Rails.application.config.perform_caching_queries = true }

      it { expect(Rails.cache).to receive(:fetch).with(cache_key, cache_options) }

      after { described_class.data }
    end
  end
end

class TestSource < Apress::Sources::CachedSource
  class << self
    def init_data
      {object: {field: :value}}
    end

    def cache_expires_in
      2.hours
    end
  end
end

describe TestSource do
  describe '.cache_options' do
    it { expect(described_class.send(:cache_options)).to eq(expires_in: 2.hours, tags: ['test_source']) }
  end

  describe '.data' do
    it { expect(described_class.data).to eq(object: {field: :value}) }
  end
end
