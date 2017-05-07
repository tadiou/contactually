require 'rails_helper'

RSpec.describe NormalizePhone::Base, type: :service do
  let(:not_a_phone_number) { 'This isn\'t a phone number' }
  let(:phone_number_dashes) { '432-570-6089' }
  let(:phone_number_parens) { '(153)156-8305' }
  let(:phone_number_dots) { '218.783.3992' }
  let(:phone_number_parens_leading_one) { '1-432-570-6089' }

  describe '.normalize' do
    context 'Not a Phone Number' do
      it 'raises a NotAPhoneNumber error' do
      end
    end

    context 'Leading 1' do
      it 'returns a normalized phone number' do
      end
    end

    context 'Parentheses' do
      it 'returns a normalized phone number' do
      end
    end

    context 'Dots' do
      it 'returns a normalized phone number' do
      end
    end
  end

  describe '.strip_numbers!' do
    # usually I'd share these between .normalize  and .strip_numbers! using a shared
    #   context
    context 'Not a Phone Number' do
      it 'raises a NotAPhoneNumber error' do
        klass = described_class.new(not_a_phone_number)
        expect(klass.strip_numbers!(klass.phone_number)).to eq('')
      end
    end

    context 'Leading 1' do
      it 'returns a normalized phone number' do
        klass = described_class.new(phone_number_parens_leading_one)
        expect(klass.strip_numbers!(klass.phone_number)).to eq('14325706089')
      end
    end

    context 'Parentheses' do
      it 'returns a normalized phone number' do
      end
    end

    context 'Dots' do
      it 'returns a normalized phone number' do
      end
    end
  end

  describe '.remove_leading_one!' do
    let(:base) { described_class.new(phone_number_parens_leading_one) }

    it 'removes leading 1 if there\'s exactly 11 digits' do
      klass = described_class.new(phone_number_parens_leading_one)
      expect(klass.remove_leading_one!('14325706089')).to eq('4325706089')
    end

    it 'leaves things the way they are if it\'s not a leading 1 and is 11 digits' do
      klass = described_class.new(phone_number_parens_leading_one)
      expect(klass.remove_leading_one!('43257060895')).to eq('43257060895')
    end

    it 'leaves things the way they are if it\'s a leading 1 and is NOT 11 digits' do
      klass = described_class.new(phone_number_parens_leading_one)
      expect(klass.remove_leading_one!('1325706089')).to eq('1325706089')
    end
  end
end
