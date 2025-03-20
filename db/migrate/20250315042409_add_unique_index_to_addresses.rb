class AddUniqueIndexToAddresses < ActiveRecord::Migration[7.2]
  def change
    add_index :addresses, [:street, :city, :state, :zip], unique: true, name: 'index_addresses_on_full_address'
  end
end
