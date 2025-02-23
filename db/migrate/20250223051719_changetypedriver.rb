class Changetypedriver < ActiveRecord::Migration[7.2]
  def change
    change_column :rides, :driver, :text
  end
end
