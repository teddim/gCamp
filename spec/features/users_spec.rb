require 'rails_helper'


feature 'Users CRUD Happy Path-' do

  before do
    login
  end

  scenario 'CREATE: User can create a new user' do
    visit users_path
    click_on 'New User'
    fill_in 'First name', with: 'Tester'
    fill_in 'Last name', with: 'Test'
    fill_in 'Email', with: 't@t.com'

    click_on 'Create User'
    expect(page).to have_content('Tester')
    expect(page).to have_content('Test')
    expect(page).to have_content('t@t.com')
  end

  xscenario 'READ: User can see a user on the index page' do
    login
    visit users_path
    # within(".h1.page-header") do
    #   expect(page).to have_content('Users')
    # end
    expect(page).to have_content('Tester')
    expect(page).to have_content('Test')
    expect(page).to have_content('t@t.com')
  end

  xscenario 'READ: User can view a single user on the show page' do
    login
    visit users_path
    click_on 'Tester'

    # within(".h1.page-header") do
    #   expect(page).to have_content('Tester Test')
    # end
    expect(page).to have_content('Tester')
    expect(page).to have_content('Test')
    expect(page).to have_content('t@t.com')
  end

  xscenario 'UPDATE: User can update a user' do
    User.create!(
    first_name: 'Tester',
    last_name:'Test',
    email: 't@t.com',
    password: 'test'
    )
    visit users_path
    click_on 'Edit'
    fill_in 'First name', with: 'My edited user'
    fill_in 'Last name', with: 'Apple'
    fill_in 'Email', with: 't2@t.com'
    click_on 'Update'
    expect(page).to have_content('My edited user')
    expect(page).to have_content('Apple')
    expect(page).to have_content('t2@t.com')
  end

  xscenario 'DELETE: User can delete a user' do
    User.create!(
    first_name: 'Tester',
    last_name:'Test',
    email: 't@t.com',
    password: 'test'
    )
    visit users_path
    click_on 'Edit'
    click_on 'Delete'
    expect(page).to have_no_content('Tester')
    expect(page).to have_no_content('Test')
    expect(page).to have_no_content('t@t.com')
    expect(page).to have_content('User was successfully deleted')
  end
end

feature "Users CRUD validation:" do

  xscenario 'User can\'t create a new user without entering required data' do
    visit users_path
    click_on 'New User'
    click_on 'Create User'
    expect(page).to have_content(/prohibited this form from being saved/)
  end
end
