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
#  extension     :string
#

require 'csv'

class Contact
  # We're separating out the CSV upload from Contact
  #   because it's specific to the context of the Contact
  #   but not related to the core functionality of the model.
  #
  # We don't actually need to use paperclip here (I had thought about it)
  #   but ultimately the point is: we only care about the upload
  #   for the lenght of the request and no longer. Once it's uploaded
  #   there isn't really a need for holding onto it, and to just do a simple
  #   multipart upload is considerably easier.
  class AsCSV
    attr_reader :csv

    def initialize(file, _opts = {})
      @csv = CSV.read(file, headers: false)
    end

    # Since we're only dealing with one format here, and we don't have to do
    #   any fuzzy searching from headers to schema (and we're not handling explicit
    #   matching either), this should be 'good enough'.
    def import
      @csv.shift # we're skipping the header line, ideally this'd be optioned
      @csv.each do |row|
        # Ideally we wouldn't fail silently & go back & return
        #   failed contacts imported
        Contact.create(first_name: row[0], last_name: row[1], email_address: row[2],
                       phone_number: row[3], company_name: row[4])
      end
    end
  end
end
