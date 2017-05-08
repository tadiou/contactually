class ContactCsvMassUploadJob < ActiveJob::Base
  queue_as :default

  def perform(file)
    
  end
end
