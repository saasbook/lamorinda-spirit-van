# frozen_string_literal: true

class Ride < ApplicationRecord
  belongs_to :passenger, optional: true
  belongs_to :driver
  belongs_to :start_address, class_name: 'Address', foreign_key: :start_address_id
  belongs_to :dest_address, class_name: 'Address', foreign_key: :dest_address_id

  def emailed_driver?
    self.emailed_driver == "true"
  end

end
