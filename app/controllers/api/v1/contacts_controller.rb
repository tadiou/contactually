module Api
  module V1
    # Because we're handling bulk uploading outside via the Api::v1::Contacts::UploadsController
    #   we only need index, show, and destroy. Nothing else.
    class ContactsController < ApiController
      before_action :set_contact, only: :show

      # Route: /api/v1/contacts.json
      # Method: GET
      def index
        @contacts = Contact.all

        render json: @contacts
      end

      # Route: /api/v1/contacts/[:id].json
      # Method: GET
      def show
        render json: @contact
      end

      # Route: /api/v1/contacts/[:id].json
      # Method: DELETE
      def destroy
        @contact.destroy

        head :no_content
      end

      private

      def set_contact
        @contact = Contact.find(params[:id])
      end
    end
  end
end
