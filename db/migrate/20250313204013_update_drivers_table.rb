class UpdateDriversTable < ActiveRecord::Migration[7.2]
  def change
    remove_column :drivers, :shifts, :json, if_exists: true
  end
end
