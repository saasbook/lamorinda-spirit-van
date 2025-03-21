# frozen_string_literal: true

FactoryBot.define do
    factory :ride do
      association :start_address, factory: :address
      association :dest_address, factory: :address
      association :passenger
      association :driver
      van { 1 }
      hours { 1.0 }
      date { Time.zone.today }
      amount_paid { 0 }
      emailed_driver { false }
    end
  end
