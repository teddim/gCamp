def create_user(overrides={})
  User.create!({
    first_name: 'Tester',
    last_name:'Test',
    email: 't@t.com',
    password: 'test',
    password_confirmation: 'test',
    admin: true
  }.merge(overrides))
end

def create_member(overrides={})
  project = create_project
  Membership.create!({
    role: 'member',
    user_id: User.first,
    project_id: project.id
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

def destroy_records
  User.destroy_all
  Membership.destroy_all
  Project.destroy_all
end
