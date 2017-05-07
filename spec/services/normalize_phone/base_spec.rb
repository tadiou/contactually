require 'rails_helper'

RSpec.describe NormalizePhone::Base, type: :service do
  subject(:normalize_phone_service) { described_class.new(phone_number) }

  describe 'Normalizes Phone Number' do
    context 'Not a Phone Number' do
      let(:phone_number) { 'This isn\'t a phone number' }

      it 'raises a NotAPhoneNumber error' do
        expect { normalize_phone_service }.to raise_error(NotAPhoneNumberError)
      end
    end

    context 'Leading 1' do
      let(:phone_number) { '1-432-570-6089' }

      it 'returns a normalized phone number' do
      end
    end

    context 'Parentheses' do
      let(:phone_number) { '(153)156-8305' }

      it 'returns a normalized phone number' do
      end
    end

    context 'Dots' do
      let(:phone_number) { '218.783.3992' }

      it 'returns a normalized phone number' do
      end
    end
  end
end
