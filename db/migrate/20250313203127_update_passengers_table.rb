class UpdatePassengersTable < ActiveRecord::Migration[7.2]
  def change
    remove_column :passengers, :first_name, :string, if_exists: true
    remove_column :passengers, :last_name, :string, if_exists: true
    remove_column :passengers, :address, :string, if_exists: true
    remove_column :passengers, :city, :string, if_exists: true
    remove_column :passengers, :state, :string, if_exists: true
    remove_column :passengers, :zip, :string, if_exists: true
    remove_column :passengers, :full_name, :string, if_exists: true

    add_reference :passengers, :address, foreign_key: true, index: true

    add_column :passengers, :name, :string
    remove_column :passengers, :birthday, :date, if_exists: true
    add_column :passengers, :birthday, :datetime, if_exists: true

    remove_column :passengers, :hispanic, :string, if_exists: true
    add_column :passengers, :hispanic, :binary
  
    remove_column :passengers, :date_registered, :date, if_exists: true
    add_column :passengers, :date_registered, :datetime
  end
end
