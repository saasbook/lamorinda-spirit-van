class Removenulls1 < ActiveRecord::Migration[7.2]
  def change
    change_column :rides, :passenger_name_and_phone, :text
    change_column :rides, :passenger_address, :text
    change_column :rides, :notes_to_driver, :text
    change_column :rides, :notes_date_reserved, :text
    change_column :rides, :destination, :text
    change_column :rides, :confirmed_with_passenger, :text


  end
end

