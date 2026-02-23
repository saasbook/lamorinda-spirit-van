class RemoveRideCountFromRides < ActiveRecord::Migration[7.2]
  def change
    remove_column :rides, :ride_count, :integer
  end
end
