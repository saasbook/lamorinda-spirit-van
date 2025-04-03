# frozen_string_literal: true

Given("the following user exists:") do |table|
  table.hashes.each do |row|
    User.create!(
      email: row["email"],
      password: row["password"],
      password_confirmation: row["password"],
      role: row["role"].presence
    )
  end
end

When("I fill in {string} with {string}") do |field, value|
  fill_in field, with: value
end

When("I press {string}") do |button|
  click_button button
end

Then("I should see {string}") do |text|
  expect(page).to have_content(text)
end
