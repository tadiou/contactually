# I realized after going through the CSV that there's extensions! Separate those out
#   because they're not handled in a standard way and this allows us to
#   possibly build some validation for phone/country code down the line.
# Not actually an overengineering here (to create MVP), but something that'll
#   allow us to consistently display an output regardless of the format
class AddExtensionToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :extension, :string
  end
end
