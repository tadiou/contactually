module Api
  class ContactsController < ApplicationController
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