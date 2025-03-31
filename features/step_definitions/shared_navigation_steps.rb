# frozen_string_literal: true

Given("I am on the {string} page") do |page_name|
  case page_name
  when "home"
    visit root_path
  when "Today's Rides"
    visit today_rides_path
  when "Read-Only Shift Calendar"
    visit read_only_shifts_path
  when "Shifts Calendar"
    visit shifts_path
  else
    raise "Unknown page name: #{page_name}"
  end
end

When("I click on {string} button") do |button_text|
  click_button(button_text) rescue click_link(button_text)
end

Then("I should be on the {string} page") do |page_name|
  case page_name
  when "Today's Rides"
    expect(current_path).to eq today_rides_path
  when "Read-Only Shift Calendar"
    expect(current_path).to eq read_only_shifts_path
  when "Shifts Calendar"
    expect(current_path).to eq shifts_path
  when "New Shift"
    expect(page.current_url).to include("/shifts/new")
    expect(page.current_url).to include("date=#{@clicked_date}")
  when "Driver's All Shifts"
    expect(current_path).to match(/\/drivers\/\d+\/all_shifts/)
  when "Shift Details"
    expect(current_path).to match(/\/shifts\/\d+/)
  else
    raise "Unknown page name: #{page_name}"
  end
end

Then("I should see {string} button") do |button_text|
  found = page.has_button?(button_text) || page.has_link?(button_text)
  expect(found).to be true
end
