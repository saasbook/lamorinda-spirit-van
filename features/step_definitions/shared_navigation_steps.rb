# frozen_string_literal: true

When("I click on {string} button") do |button_text|
  click_button(button_text) rescue click_link(button_text)
end


Then("I should see {string} button") do |button_text|
  found = page.has_button?(button_text) || page.has_link?(button_text)
  expect(found).to be true
end
