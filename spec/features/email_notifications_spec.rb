require "rails_helper"

describe "following" do
  let!(:hisas) { create(:hisas) }

  before do
    log_in_as(hisas)
    visit settings_notifications_path
  end

  it "turn on/off followed_notification" do
    expect(page).to have_button "Turn off"
    click_button "Turn off"
    expect(page).to have_button "Turn on"
    click_button "Turn on"
    expect(page).to have_button "Turn off"
  end
end
