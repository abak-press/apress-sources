# coding: utf-8
require 'spec_helper'

describe Apress::Sources::Translator do
  let(:field) { '2016-01-01' }
  let(:field_name) { :f }
  let(:params) { {object: {f: field}, field: field_name} }

  shared_examples :only_existing_field do |type|
    let(:field_name) { :random_field }

    it { expect { described_class.send("value_as_#{type}", params) }.to raise_error(KeyError) }
  end

  describe '.value_as_string' do
    it_behaves_like :only_existing_field, :string

    context 'when empty field' do
      let(:field) { nil }

      it { expect(described_class.value_as_string(params)).to eq '' }
    end

    context 'when presented field' do
      it { expect(described_class.value_as_string(params)).to eq field }
    end
  end

  describe '.value_as_integer' do
    it_behaves_like :only_existing_field, :integer

    context 'when empty field' do
      let(:field) { nil }

      it { expect(described_class.value_as_integer(params)).to eq 0 }
    end

    context 'when presented field' do
      it { expect(described_class.value_as_integer(params)).to eq 2016 }
    end
  end

  describe '.value_as_boolean' do
    it_behaves_like :only_existing_field, :boolean

    context 'when empty field' do
      let(:field) { nil }

      it { expect(described_class.value_as_boolean(params)).to eq false }
    end

    context 'when field not true' do
      it { expect(described_class.value_as_boolean(params)).to be false }
    end

    context 'when field is true' do
      let(:field) { 't' }

      it { expect(described_class.value_as_boolean(params)).to be true }
    end
  end

  describe '.value_as_date' do
    it_behaves_like :only_existing_field, :date

    context 'when empty field' do
      let(:field) { nil }

      it { expect(described_class.value_as_date(params)).to be_nil }
    end

    context 'when presented field' do
      it { expect(described_class.value_as_date(params)).to eq field.to_date }
    end
  end
end
