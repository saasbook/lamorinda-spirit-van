class ChangeNull < ActiveRecord::Migration[7.2]
  def change
    change_column_null :rides, :notes_to_driver, true
    change_column_null :rides, :notes_date_reserved, true
    change_column_null :rides, :confirmed_with_passenger, true
    change_column_null :rides, :driver_email, true
    change_column_null :rides, :driver, true
    change_column_null :rides, :van, true
    change_column_null :rides, :driver_initials, true
    change_column_null :rides, :hours, true
    change_column_null :rides, :amount_paid, true
    change_column_null :rides, :ride_count, true
    change_column_null :rides, :c, true
  end
end

