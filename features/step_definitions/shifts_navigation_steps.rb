# frozen_string_literal: true

Given("I am on the {string} page") do |page_name|
  case page_name
  when "homepage"
    visit root_path
  when "Today's Rides"
    visit today_rides_path
  when "Read-Only Shift Calendar"
    visit read_only_shifts_path
  else
    raise "Unknown page name: #{page_name}"
  end
end

When("I click on {string} button") do |button_text|
  click_button(button_text) rescue click_link(button_text)
end

Then("I should be on the {string} page") do |page_name|
  expected_path = case page_name
                  when "Today's Rides"
                    today_rides_path
                  when "Read-Only Shift Calendar"
                    read_only_shifts_path
                  else
                    raise "Unknown page name: #{page_name}"
  end

  expect(current_path).to eq expected_path
end

Then("I should see {string} button") do |button_text|
  # search button or link
  found = page.has_button?(button_text) || page.has_link?(button_text)
  expect(found).to be true
end

Then("I should see the current month and year in the calendar title") do
  expected_title = Time.zone.today.strftime("%B %Y") # e.g., "March 2025"
  actual_title = find(".calendar-title").text
  expect(actual_title).to eq(expected_title)
end

Then("I should see {string} {string} {string} button") do |btn1, btn2, btn3|
  [btn1, btn2, btn3].each do |btn|
    found = page.has_button?(btn) || page.has_link?(btn)
    expect(found).to be true
  end
end

When("I note the current month title") do
  @current_month = find(".calendar-title").text
end

Then("I should see the month title change") do
  new_month = find(".calendar-title").text
  expect(new_month).not_to eq(@current_month)
end

Then("I should see the current month title again") do
  current_month = find(".calendar-title").text
  expect(current_month).to eq(@current_month)
end
