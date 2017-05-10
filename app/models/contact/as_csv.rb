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
      # we're skipping the header line, ideally this'd be optioned
      @csv.tap(&:shift).each do |row|
        # Ideally we wouldn't fail silently & go back & return
        #   failed contacts imported, and we shouldn't import duplicates
        # I thought something to do find or createby to index off of would be nice
        #   also it made it easier for me to test importation
        # email_address should be indexed.
        # Also Find or Create by is wildly inefficient when doing bulk imports
        #   ideally what I'd rather do is diff the two lists when putting
        #   them together by getting all email addresses in the db and doing
        #   array subtraction to find what the import list has that the
        #   db does not.
        # Lastly, as we're doing a bulk import of a single unit, we'd like to ensure
        #   that they all go off without a hitch, ergo: transaction.
        Contact.transaction do
          Contact.find_or_create_by(email_address: row[2]) do |contact|
            contact.first_name = row[0]
            contact.last_name = row[1]
            contact.phone_number = row[3]
            contact.company_name = row[4]
          end
        end
      end
    end
  end
end
