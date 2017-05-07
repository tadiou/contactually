class NormalizePhone
  class Base
    attr_reader :phone_number

    # Can't use /d because /d matches to certain Arabic numerals which aren't
    #   used in phone numbers. I've spent way too much time handling international
    #   use cases.
    NUMBERS_ONLY_REGEX = /^[0-9]+$/

    def initialize(string)

    end


  end
end
