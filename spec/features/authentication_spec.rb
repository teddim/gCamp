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

feature 'Sign In -' do

  scenario 'Guest can sign in successfully' do
    create_user
    visit root_path
    within('ul.navbar-right') do
      click_on 'Sign In'
    end
    fill_in 'Email', with: 't@t.com'
    fill_in 'Password', with: 'test'
    click_on 'Sign in'

    expect(page).to have_content('Tester Test')
    expect(page).to have_content('You have successfully signed in')
    expect(current_path).to eq root_path
  end

  scenario 'Guest can\'t sign in without entering required data' do
    create_user
    visit signin_path
    click_on 'Sign in'
    expect(page).to have_content("Email / Password combination is invalid")
  end
end
