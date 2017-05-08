require 'rails_helper'

RSpec.describe NormalizePhone, type: :model do
  subject(:normalize_phone_service) { described_class.new(phone_number) }

  let(:phone_number) { '1-630-723-7263 x 12345' }

  # Doesn't actually describe the functionality of base/extension
  #   but just ensures that it has the accessors necessary.
  describe 'Normalizes Phone Number' do
    it 'has a phone accessor' do
      expect(normalize_phone_service.phone).to eq('6307237263')
    end

    it 'has an extension accessor' do
      expect(normalize_phone_service.extension).to eq('12345')
    end
  end
end
