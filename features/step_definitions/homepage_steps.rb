Given("I visit the Homepage") do
  visit root_path
end
  
Then("I should see {string}") do |text|
  expect(page).to have_content(text)
end