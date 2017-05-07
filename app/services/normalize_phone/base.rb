class NormalizePhone
  # Just a really simple implementation. We're doing V1 here, not a really complicated
  #   rules engine of how to look at phone numbers.
  # Ideally PhoneNumber would become it's own value object with it's own rule sets
  #   which are dependent on internationalization rules et al, and we'd be able to
  #   implement different normalization interfaces throughout.
  class Base
    attr_reader :phone_number

    # Can't use /d because /d matches to certain Arabic numerals which aren't
    #   used in phone numbers. I've spent way too much time handling international
    #   use cases.
    NUMBERS_ONLY_REGEX = /[0-9]+/
    MIN_PHONE_DIGITS = 10

    def initialize(string)
      @phone_number = NormalizePhone::Extension.split(string).phone_number
    end

    # Enacts normalization procedurally
    # @param [String]
    # @return [String]
    def normalize(phone_number = nil)
      @phone_number ||= phone_number
      strip_numbers!(@phone_number)
      remove_leading_one!(@phone_number)
      raise NormalizePhone::NotAPhoneNumberError if @phone_number.size < MIN_PHONE_DIGITS
      @phone_number
    end

    # Strips down a string to only regex [0-9]. Bang method. Replaces in place.
    # @param [String]
    # @return [String]
    def strip_numbers!(phone_number)
      phone_number.replace(phone_number.scan(NUMBERS_ONLY_REGEX).join)
    end

    # Removes the leading 1 for all phones if it's exactly
    #   11 digits loing. Bang method. Replaces in place.
    # @param [String]
    # @return [String]
    def remove_leading_one!(phone_number)
      return phone_number if phone_number.first != '1' # country code is applicable here
      return phone_number if phone_number.size != MIN_PHONE_DIGITS + 1
      phone_number.replace(phone_number.slice(1..-1))
    end
  end
end
