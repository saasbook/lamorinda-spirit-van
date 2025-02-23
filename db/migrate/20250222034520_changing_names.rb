class ChangingNames < ActiveRecord::Migration[7.2]
  def change
    rename_column :rides, :passenger_name, :passenger_name_and_phone
    rename_column :rides, :driver_notes, :notes_to_driver
    rename_column :rides, :address, :passenger_address
    rename_column :rides, :date_reserved_notes, :notes_date_reserve
    rename_column :rides, :confirmed_w_passenger, :confirmed_with_passenger

  end
end
