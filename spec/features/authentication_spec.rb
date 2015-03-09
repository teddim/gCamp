require 'rails_helper'


feature 'Sign Out button-' do

  scenario 'Guest can sign out successfully' do
    login
    click_on 'Sign Out'
    expect(page).to have_no_content('Tester2 Test2')
    expect(page).to have_content('You have successfully logged out')
    expect(current_path).to eq root_path
  end

end
