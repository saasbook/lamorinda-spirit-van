class Removenulls < ActiveRecord::Migration[7.2]
  def change
    change_column_null :rides, :passenger_name_and_phone, true
  end
end
