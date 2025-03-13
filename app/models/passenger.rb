# frozen_string_literal: true

class Passenger < ApplicationRecord
  has_one :address, dependent: :destroy
  has_many :rides, dependent: :nullify
end
