class Passenger < ApplicationRecord
    validates :first_name, :last_name, :full_name, :address, :city, :zip, :phone, :birthday, :race, :date_registered, presence: true
    validates :state, presence: true, inclusion: { in: [ "CA" ] }
    validates :phone, format: { with: /\A\(\d{3}\)\d{3}-\d{3}\z/, message: "must be in format (xxx)xxx-xxx" }
end
