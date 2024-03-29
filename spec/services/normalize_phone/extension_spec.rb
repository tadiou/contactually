require 'rails_helper'

RSpec.describe NormalizePhone::Extension, type: :services do
  subject(:normalize_extension_service) { described_class.new(phone_number) }

  describe '.normalize' do
    it 'with x: 1-847-742-3843 x12047 returns 12047' do
      klass = described_class.new('1-847-742-3843 x12047')
      expect(klass.normalize(klass.extension)).to eq('12047')
    end

    it 'with x: 1-847-742-3843 x12047  (whitespace)  returns 12047' do
      klass = described_class.new('1-847-742-3843 x12047    ')
      expect(klass.normalize(klass.extension)).to eq('12047')
    end

    it 'with x: 1-847-742-3843 x 12047  (whitespace)  returns 12047' do
      klass = described_class.new('1-847-742-3843 x 12047    ')
      expect(klass.normalize(klass.extension)).to eq('12047')
    end

    it 'with x: 1-847-742-3843 x120x47 returns ExtensionContainsNonnumericsError' do
      klass = described_class.new('1-847-742-3843 x120x47')
      expect { klass.normalize(klass.extension) }
        .to raise_error(NormalizePhone::ExtensionContainsNonnumericsError)
    end
  end

  describe '#split' do
    # This context specifically exists because I know it's written as ext in places
    #   and allows the flexibility to be extended in the future without being too
    #   focused on what the terms are.
    context 'with x: 1-847-742-3843 x12047' do
      let(:phone_number) { '1-847-742-3843 x12047' }

      it 'returns an object with the first segement as \'the phone number\'' do
        expect(NormalizePhone::Extension.split(phone_number).phone_number).to eq '1-847-742-3843'
      end

      it 'returns an object with the last segement as \'the extension\'' do
        expect(NormalizePhone::Extension.split(phone_number).extension).to eq '12047'
      end
    end

    context 'without extension: 1-847-742-3843' do
      let(:phone_number) { '1-847-742-3843' }

      it 'returns an object with the first segement as \'the phone number\'' do
        expect(NormalizePhone::Extension.split(phone_number).phone_number).to eq '1-847-742-3843'
      end

      it 'returns nil for .extension' do
        expect(NormalizePhone::Extension.split(phone_number).extension).to eq nil
      end
    end
  end
end
