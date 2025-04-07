# frozen_string_literal: true

Given(/^I am logged in as a dispatcher$/) do
  @dispatcher = FactoryBot.create(:user,
                                  :dispatcher,
                                  email: "dispatcher1@example.com",
                                  password: "password")
  visit new_user_session_path

  fill_in "Email", with: @dispatcher.email
  fill_in "Password", with: @dispatcher.password
  click_button "Log in"

  expect(page).not_to have_content("Log in")
  expect(page).to have_title("Lamorinda")
end
