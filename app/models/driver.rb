# frozen_string_literal: true

class Driver < ApplicationRecord
  validates :name, :phone, presence: true
  validates :email, :active, presence: false
end
