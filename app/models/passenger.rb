# frozen_string_literal: true

class Passenger < ApplicationRecord
  # since passenger has the associated address_id, it should have the belongs_to
  belongs_to :address
  # for new address record whne creating new passenger
  accepts_nested_attributes_for :address
  has_many :rides, dependent: :nullify


  def assign_address(street:, city:, state:, zip:)
    self.address = Address.find_or_create_by(
      street: street.strip.titleize,
      city: city.strip.titleize,
      state: state.strip.upcase,
      zip: zip.strip
    )
  end

  def full_address
    [address.street, address.state, address.zip].compact.join(', ')
  end

  def hispanic?
    self.hispanic == "true"
  end
  
end
