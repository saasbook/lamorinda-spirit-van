class RenameMoreColumns2 < ActiveRecord::Migration[7.2]
  def change
    rename_column :rides, :notes_date_reserve, :notes_date_reserved
  end
end
