class Changetypeamt < ActiveRecord::Migration[7.2]
  def change
    change_column :rides, :amount_paid, :decimal, precision: 10, scale: 2
  end
end
