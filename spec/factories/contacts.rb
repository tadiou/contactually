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

FactoryGirl.define do
  factory :contact do
    first_name "MyString"
    last_name "MyString"
    email_address "MyString"
    phone_number "MyString"
    company_name "MyString"
  end
end
