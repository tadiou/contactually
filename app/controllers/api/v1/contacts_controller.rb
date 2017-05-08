module Api
  module V1
    class ContactsController < ApiController
      def index
      end

      def create
      end

      def show
      end

      private

      def contact_params
        params.require(:contact)
      end
    end
  end
end
