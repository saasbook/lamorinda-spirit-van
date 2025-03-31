# frozen_string_literal: true

Then("I should see the current month and year in the calendar title") do
  expected_title = Time.zone.today.strftime("%B %Y")
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
