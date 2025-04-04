# frozen_string_literal: true

Given("I visit the Homepage") do
  visit root_path
end

# Then(/^I should see "(.*?)"$/) do |text|
#   within("body") do
#     expect(page).to have_content(text)
#   end
# end
