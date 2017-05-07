class NormalizePhone
  # Handles extension related aspects of normalization of phone numbers
  class Extension
    VALID_EXTENSION_VALUES = /x/

    # This could be more robust with ensuring that there's a higher
    #   rigidity in regards to string normalization, but based off of the
    #   rough estimates of the data
    def self.split(string)
      string = string.partition(VALID_EXTENSION_VALUES)
      OpenStruct.new(phone_number: string.first.chomp(' '),
                     extension: string.last. presence || nil,
                     extension_value: string[1].presence || nil)
    rescue
      throw NormalizePhone::NotAPhoneNumberError
    end
  end
end
