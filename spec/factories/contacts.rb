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
  # I realize that it's only generating US phones, not international phones,
  #   but because we're checking against very specific phone number types
  #   when we're building out the phone normalizer, we'll address them
  #   as they come instead of relying on random Faker data.
  factory :contact do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email_address Faker::Internet.email
    phone_number Faker::PhoneNumber
    extension nil
    company_name Faker::Company.name
  end
end
