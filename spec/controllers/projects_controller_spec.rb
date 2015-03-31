require 'rails_helper'

describe ProjectsController do

  let(:user) { create_user}
  let(:project) {create_project}
  let(:membership) {create_membership(user_id: user.id, project_id: project.id)}

  describe "GET #index" do
    context 'when admin' do
      it "shows all projects" do
        session[:user_id] = user.id
        get :index
        expect(assigns(:projects)).to eq(Project.all)
        expect(response).to render_template(:index)
      end
    end
    context 'when owner or member' do
      it "shows only the user's projects" do
        user2 =  create_user(admin: false, email: 'tester2@test.com')
        project2 = create_project(name: "another project")
        session[:user_id] = user2.id
        get :index
        expect(assigns(:projects)).to eq([project2])
        expect(response).to render_template(:index)
      end
    end
  end

  describe "GET #show" do
    context 'when admin' do
      it "shows the project show page" do
        session[:user_id] = user.id
        get :show, id: project.id
        expect(assigns(:project)).to eq(project)
        expect(response).to render_template(:show)
      end
    end
    context 'when member or owner' do
      it "will not show the project show page" do
        project = create_project
        user2 =  create_user(admin: false, email: 'tester2@test.com')
        membership = create_member(user_id: user.id, project_id: project.id)
        session[:user_id] = user2.id
        get :show, id: project.id
        expect(response).to redirect_to(projects_path)
      end
    end
  end

  describe "GET #new" do
    it "allows the user to create a new project" do
      session[:user_id] = user.id
      get :new
      expect(assigns(:project)).to be_a_new(Project)
      expect(assigns(:membership)).to be_a_new(Membership)
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "allows a user to create" do
      session[:user_id] = user.id
      post :create, {project: {name: "a created project" }}
      expect(response).to have_http_status(302)
    end
  end

  describe "GET #edit" do
    it "does not allow non-owners to edit" do
      user2 =  create_user(admin: false, email: 'tester2@test.com')
      session[:user_id] = user2.id
      get :edit, id: project.id
      expect(response).to redirect_to(projects_path)
    end
  end

  describe "POST #update" do
    it "does not allow non-owners to update" do
      user2 =  create_user(admin: false, email: 'tester2@test.com')
      session[:user_id] = user2.id
      get :update, id: project.id
      expect(response).to redirect_to(projects_path)
    end
  end

  describe "GET #destroy" do
    it "does not allow non-owners to delete" do
      user2 =  create_user(admin: false, email: 'tester2@test.com')
      project2 = create_project(name: "another project")
      session[:user_id] = user2.id
      project = Project.create!(name: "something")
      delete :destroy, {:id => project.to_param}
      expect(response).to redirect_to(projects_path)
    end
  end

end
