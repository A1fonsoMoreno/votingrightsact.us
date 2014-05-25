require "spec_helper"

feature "Visit the homepage" do
  background do
    visit root_path
  end

  scenario "when successful" do
    expect(page.status_code).to eq 200
  end
end