class Removephonecol < ActiveRecord::Migration[7.2]
  def change
    remove_column :rides, :phone, :string
  end
end
