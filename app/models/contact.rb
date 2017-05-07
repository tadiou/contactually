# == Schema Information
#
# Table name: contacts
#
#  id            :integer          not null, primary key
#  first_name    :string
#  last_name     :string
#  email_address :string
#  phone_number  :string
#  company_name  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# Contact is the base record of the application.
class Contact < ActiveRecord::Base
  before_save :normalize_phone

  # no validation because that wasn't discussed.

  private

  def normalize_phone
    self.phone, self.extension = NormalizePhone.normalize(phone)
  end
end
