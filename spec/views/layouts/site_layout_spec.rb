require "rails_helper"

describe "test site layout", type: :view do
  it "should have correct layout links" do
    visit root_path
    expect(page).to have_link "Home", href: root_path
    expect(page).to have_link "sample app", href: root_path
    expect(page).to have_link "Help", href: help_path
    expect(page).to have_link "About", href: about_path
    expect(page).to have_link "Contact", href: contact_path
  end
end
