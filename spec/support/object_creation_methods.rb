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
  project = create_project
  Task.create!({
    description: 'My task for today',
    due_date: 20150303,
    project_id: project.id
  }.merge(overrides))
end

def create_project(overrides={})
    Project.create!({
      name: 'My project for today',
    }.merge(overrides))
end
