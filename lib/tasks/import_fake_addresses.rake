# frozen_string_literal: true

require "csv"

namespace :import do
  desc "Import fake addresses from CSV"
  task fake_addresses: :environment do
    require Rails.root.join("app", "models", "address")

    file_path = Rails.root.join("db", "fake_addresses_lamorinda.csv")

    unless File.exist?(file_path)
      puts "CSV file not found at #{file_path}"
      exit
    end

    # Delete existing addresses
    Address.delete_all

    CSV.foreach(file_path, headers: true) do |row|
          puts "Row Data: #{row.to_h}"
          # Create a new Address record
          Address.create!(
              street: row["street"],
              city: row["city"],
              state: row["state"],
              zip: row["zip"]
            )
        end
  end
end
