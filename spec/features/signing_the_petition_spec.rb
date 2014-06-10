require "spec_helper"

feature "Signing the petition", js: true do
  background do
    visit root_path
  end

  scenario "with all required fields" do
    fill_in "First name", with: Faker::Name.first_name
    fill_in "Last name", with: Faker::Name.last_name
    fill_in "Email", with: Faker::Internet.free_email
    fill_in "Zipcode", with: Faker::Address.zip_code

    click_on "Sign the Petition"

    expect(page).to have_content("Thanks")
  end
end