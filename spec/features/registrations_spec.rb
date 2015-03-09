require 'rails_helper'


feature 'Sign Up page-' do


  scenario 'Guest can sign up successfully' do
    visit signup_path
    fill_in 'First name', with: 'Tester2'
    fill_in 'Last name', with: 'Test2'
    fill_in 'Email', with: 't@t2.com'
    fill_in 'Password', with: 'test'
    fill_in 'Password confirmation', with: 'test'
    within(".form-horizontal") do
      click_on 'Sign Up'
    end
    expect(page).to have_content('Tester2 Test2')
    expect(page).to have_content('You have successfully signed up')
    expect(current_path).to eq root_path
  end

  scenario 'User can\'t create a new account without entering required data' do
    login
    visit signup_path
    click_on 'Sign Up'
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    fill_in 'Email', with: 't@t.com'
    click_on 'Sign Up'
    expect(page).to have_content("Email has already been taken")


  end
end
