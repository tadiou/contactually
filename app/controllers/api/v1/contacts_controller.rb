module Api
  module V1
    # Because we're handling bulk uploading outside via the Api::v1::Contacts::UploadsController
    #   we only need index, show, and destroy. Nothing else.
    class ContactsController < ApiController
      def index
        @contacts = Contacts.all

        render json: @contacts
      end

      def show
        render json: @contact
      end

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
