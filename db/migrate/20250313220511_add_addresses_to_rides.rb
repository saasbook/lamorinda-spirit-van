class AddAddressesToRides < ActiveRecord::Migration[7.2]
  def change
    add_column :rides, :start_address_id, :integer
    add_column :rides, :dest_address_id, :integer
  end
end
