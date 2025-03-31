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


Then("I should see each day has a button for create a new shift") do
  day_cells = all("td")
  shift_buttons = day_cells.select { |td| td.has_link?("New shift") }
  expect(shift_buttons.count).to be > 0
end


When("I click one day's {string} button") do |button_text|
  # Select all "New shift" table cells
  candidate_cells = all("td").select { |td| td.has_link?(button_text) }

  raise "No '#{button_text}' button found in any day cell" if candidate_cells.empty?

  # Choose one cell randomly
  target_cell = candidate_cells.sample

  # Extract the date from the cell
  clicked_date_str = target_cell.text.match(/\d{4}-\d{2}-\d{2}/)&.to_s
  unless clicked_date_str
    clicked_date_str = target_cell.find("a", text: button_text)[:href].match(/date=(\d{4}-\d{2}-\d{2})/)&.captures&.first
  end
  raise "Could not extract date from cell" unless clicked_date_str

  # Convert the date string to a Date object
  @clicked_date = Date.parse(clicked_date_str)

  # Click the button
  target_cell.click_link(button_text)
end

Then("the date should initially be the date of the corresponding table") do
  input_value = find("#shift_shift_date").value
  expect(input_value).to eq @clicked_date.to_s
end


When("I click on a driver's name") do
  driver_link = find(".driver-link", match: :first)
  @clicked_driver_name = driver_link.text
  driver_link.click
end

Then("I should see a list of shifts belonging to that driver") do
  expect(page).to have_content(@clicked_driver_name)
  expect(page).to have_css("div.shift") # Assumes shift blocks have a class for styling
end

When("I click on a shift type") do
  shift_type_link = find(".shift-type-link", match: :first)
  @clicked_shift_type = shift_type_link.text
  shift_type_link.click
end

Then("I should see the details of that shift") do
  expect(page).to have_content("Shift date")
  expect(page).to have_content("Driver name")
  expect(page).to have_content("Shift type")
end
