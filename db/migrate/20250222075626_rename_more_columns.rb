class RenameMoreColumns < ActiveRecord::Migration[7.2]
  def change
      rename_column :rides, :C, :c
  end
end
