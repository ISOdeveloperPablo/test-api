require 'unit_spec_helper'

describe Shoulda::Matchers::ActiveModel::NumericalityMatchers::OddNumberMatcher  do
  subject { described_class.new(numericality_matcher, :attr) }

  it_behaves_like 'a numerical submatcher'
  it_behaves_like 'a numerical type submatcher'

  it 'allows odd number' do
    expect(subject.allowed_type).to eq 'odd numbers'
  end

  describe '#diff_to_compare' do
    it { expect(subject.diff_to_compare).to eq 2 }
  end

  context 'when the model has an odd validation' do
    it 'matches' do
      match = subject
      expect(validating_odd_number).to match
    end
  end

  context 'when the model does not have an odd validation' do
    it 'does not match' do
      match = subject
      expect(not_validating_odd_number).not_to match
    end

    it 'fails with the ActiveRecord :odd message' do
      match = subject
      expect {
        expect(not_validating_odd_number).to match
      }.to fail_with_message_including('Expected errors to include "must be odd"')
    end
  end

  context 'with custom validation message' do
    it 'only accepts odd number values for that attribute with that message' do
      expect(validating_odd_number(message: 'custom')).to subject.with_message(/custom/)
    end

    it 'fails odd number values for that attribute with another message' do
      expect(validating_odd_number(message: 'custom')).not_to subject.with_message(/wrong/)
    end
  end

  context 'asserting strict validation when validating strictly' do
    it 'accepts' do
      expect(validating_odd_number(strict: true)).to subject.strict
    end
  end

  context 'asserting non-strict validation when validating strictly' do
    it 'rejects' do
      pending 'This needs to be fixed'
      expect(validating_odd_number(strict: true)).not_to subject
    end
  end

  context 'asserting strict validation when not validating strictly' do
    it 'rejects' do
      expect(validating_odd_number).not_to subject.strict
    end
  end

  context 'qualified with on and validating with on' do
    it 'accepts' do
      expect(validating_odd_number(on: :customizable)).
        to subject.on(:customizable)
    end
  end

  context 'qualified with on but not validating with on' do
    it 'accepts since the validation never considers a context' do
      expect(validating_odd_number).to subject.on(:customizable)
    end
  end

  context 'not qualified with on but validating with on' do
    it 'rejects since the validation never runs' do
      expect(validating_odd_number(on: :customizable)).
        not_to subject
    end
  end

  def numericality_matcher
    double(:numericality_matcher, given_numeric_column?: nil)
  end

  def validating_odd_number(options = {})
    define_model :example, attr: :string do
      validates_numericality_of :attr, { odd: true }.merge(options)
    end.new
  end

  def not_validating_odd_number
    define_model(:example, attr: :string).new
  end
end
