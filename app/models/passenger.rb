# frozen_string_literal: true

class Passenger < ApplicationRecord
  belongs_to :address, dependent: :destroy
  has_many :rides, dependent: :nullify
end
