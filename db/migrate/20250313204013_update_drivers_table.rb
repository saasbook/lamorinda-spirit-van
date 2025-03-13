class UpdateDriversTable < ActiveRecord::Migration[7.2]
  def change
    remove_column :drivers, :shifts, :json, if_exists: true
    add_reference :drivers, :shifts, foreign_key: true, index: true
  end
end
