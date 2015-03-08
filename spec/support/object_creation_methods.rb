def create_user(overrides={})
  User.create!({
    first_name: 'Tester',
    last_name:'Test',
    email: 't@t.com',
    password: 'test',
    password_confirmation: 'test'
  }.merge(overrides))
end

def create_task(overrides={})
    Task.create!({
      description: 'My task for today',
      due_date: 20150303
    }.merge(overrides))
end

def create_project(overrides={})
    Project.create!({
      name: 'My project for today',
    }.merge(overrides))
end
