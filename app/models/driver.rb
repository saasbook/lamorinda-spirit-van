class Driver < ApplicationRecord
    validates :name, :phone, :shifts, :active, presence: true
    validates :email, presence: false
  # validates :phone, format: { with: /\A\(\d{3}\)\d{3}-\d{3}\z/, message: "must be in format (xxx)xxx-xxx" }
end
