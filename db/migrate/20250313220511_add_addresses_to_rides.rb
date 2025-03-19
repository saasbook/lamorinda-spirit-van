class AddAddressesToRides < ActiveRecord::Migration[7.2]
  def change
    remove_reference :rides, :address, null: false, foreign_key: true
    add_column :rides, :start_address_id, :integer
    add_column :rides, :dest_address_id, :integer
  end
end
