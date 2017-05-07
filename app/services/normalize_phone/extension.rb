class NormalizePhone
  # Handles extension related aspects of normalization of phone numbers
  class Extension
    attr_reader :extension

    NUMBERS_ONLY_REGEX = /^[0-9]+$/
    # Could build a bunch of matchers into here if needed. ext. x. extension,
    #   handle some of the possible punctuation
    VALID_EXTENSION_VALUES = /x/

    def initialize(string)
      @extension = NormalizePhone::Extension.split(string).extension
    end

    def normalize(extension = nil)
      @extension ||= extension
      return if @extension.nil?
      @extension.strip
      raise NormalizePhone::ExtensionContainsNonnumericsError if @extension !~ NUMBERS_ONLY_REGEX
      @extension
    end

    # This could be more robust with ensuring that there's a higher
    #   rigidity in regards to string normalization, but based off of the
    #   rough estimates of the data, this seemed to grasp the MVP.
    #
    # We handle the validation elsewhere
    def self.split(string)
      string = string.partition(VALID_EXTENSION_VALUES)
      OpenStruct.new(phone_number: string.first.chomp(' '),
                     extension: string.last. presence || nil,
                     extension_value: string[1].presence || nil)
    end
  end
end
