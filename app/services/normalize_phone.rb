# Service to normalize phone numbers, by doing the following
# - Converting all phone numbers to 123456789012 (no spaces without leading 1)
# - Separating out extensions into their own value
#
# This doesn't solve the following cases I thought about:
# - Impossible phone numbers (area codes starting with 1, or 0)
# - International Numbers (I thought because there was .uk you were separating
#   out country codes, but, that was an incorrect assumption)
class NormalizePhone
  attr_reader :phone, :extension

  # Access both component classes base and extension from the same string
  # @param [String] string A phone number looking string
  def initialize(string)
    @phone = NormalizePhone::Base.normalize(string)
    @extension = NormalizePhone::Extension.normalize(string)
  end
end
