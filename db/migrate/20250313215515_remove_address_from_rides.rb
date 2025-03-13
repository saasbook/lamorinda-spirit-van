class RemoveAddressFromRides < ActiveRecord::Migration[7.2]
  def change
    remove_reference :rides, :address, null: false, foreign_key: true
  end
end
