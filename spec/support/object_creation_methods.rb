def create_user(overrides={})
  User.create!(
    first_name: 'Tester',
    last_name:'Test',
    email: 't@t.com',
    password: 'test',
    password_confirmation: 'test'
  )
end
