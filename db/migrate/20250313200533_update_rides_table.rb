class UpdateRidesTable < ActiveRecord::Migration[7.2]
  def change
    remove_column :rides, :day, :string, if_exists: true
    remove_column :rides, :driver, :text, if_exists: true
    remove_column :rides, :passenger_name_and_phone, :text, if_exists:true
    remove_column :rides, :passenger_address, :text, if_exists: true
    remove_column :rides, :destination, :text, if_exists: true

    add_reference :rides, :passenger, foreign_key: true, index: true
    add_reference :rides, :driver, foreign_key: true, index: true
    add_reference :rides, :address, foreign_key: true, index: true

    remove_column :rides, :driver_initials, :string, if_exists: true
    remove_column :rides, :notes_to_driver, :text, if_exists: true
    remove_column :rides, :notes_date_served, :text, if_exists: true
    remove_column :rides, :c, :string, if_exists: true
    remove_column :rides, :driver_email, :string, if_exists: true

    add_column :rides, :notes, :text
    

  end
end
