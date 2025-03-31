# frozen_string_literal: true

Given("the following driver exists:") do |table|
  table.hashes.each do |row|
    Driver.create!(name: row["name"])
  end
end

Given("the following shift exists:") do |table|
  table.hashes.each do |row|
    driver = Driver.find_by(name: row["driver"])
    Shift.create!(
      driver: driver,
      shift_date: Date.parse(row["shift_date"]),
      shift_type: row["shift_type"]
    )
  end
end
