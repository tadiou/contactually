require 'csv'

module Api
  module V1
    module Contacts
      # Api::ContactsController
      #   Broken up into Upload Controller to handle specifically the mass
      #   upload actions.
      class UploadsController < ApiController
        def create
          Contact::AsCSV.new(params[:csv_upload].tempfile).import
        end
      end
    end
  end
end
