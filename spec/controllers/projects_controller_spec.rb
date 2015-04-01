require 'rails_helper'

describe ProjectsController do

  let(:user) {create_user}
  let(:project) {create_project}
  let(:membership) {create_member(user_id: user.id, project_id: project.id, role: "member")}
  let(:owner) {create_user(admin: false, email: 'tester3@test.com')}
  let(:admin) {create_user(admin: true, email: 'admin@test.com')}

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

    context 'when not a member or owner' do
      it "will not show the project show page" do
        user2 =  create_user(admin: false, email: 'tester2@test.com')
        session[:user_id] = user2.id

        get :show, id: project.id

        expect(response).to redirect_to(projects_path)
        expect(flash[:error]).to eq("You do not have access to that project")
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
      expect(flash[:notice]).to eq("Project was successfully created")
    end
  end

  describe "GET #edit" do
    context "when non-owner" do
      it "does not allow editing" do
        user2 =  create_user(admin: false, email: 'tester2@test.com')
        session[:user_id] = user2.id

        get :edit, id: project.id

        expect(response).to redirect_to(projects_path)
        expect(flash[:error]).to eq("You do not have access to that project")
      end
    end

    context "when owner" do
      it "allows editing" do
        create_member(project_id: project.id, user_id: owner.id, role: "owner")
        session[:user_id] = owner.id

        get :edit, id: project.id

        expect(assigns(:project)).to eq(Project.find(project.id))
      end
    end

    context "when admin" do
      it "allows editing" do
        session[:user_id] = admin.id

        get :edit, id: project.id

        expect(assigns(:project)).to eq(Project.find(project.id))
      end
    end
  end

  describe "POST #update" do
    context "when a non owner tries to update a project" do
      it "does not allow it" do
        user2 =  create_user(admin: false, email: 'tester2@test.com')
        session[:user_id] = user2.id

        post :update, id: project.id

        expect(response).to redirect_to(projects_path)
      end
    end

    context "when owner updates their own project" do
      it "updates the requested project" do
        create_member(project_id: project.id, user_id: owner.id, role: "owner")
        session[:user_id] = owner.id

        put :update, {:id => project.to_param, :project => { "name" => "new name" }}

        expect(flash[:notice]).to eq("Project was successfully updated")
        expect(response).to redirect_to(project_path(project))
      end
    end
    context "when admin" do
      it "updates the requested project" do
        session[:user_id] = admin.id

        put :update, {:id => project.to_param, :project => { "name" => "new name" }}

        expect(flash[:notice]).to eq("Project was successfully updated")
        expect(response).to redirect_to(project_path(project))
      end
    end
  end

  describe "DELETE destroy" do
    context "when non-owner" do
      it "does not allow non-owners to delete" do
        user2 =  create_user(admin: false, email: 'tester2@test.com')
        project2 = create_project(name: "another project")
        session[:user_id] = user2.id
        project = Project.create!(name: "something")

        delete :destroy, {:id => project.to_param}

        expect(response).to redirect_to(projects_path)
      end
    end

    context "when owner" do
      it "allows deletion" do
        create_member(project_id: project.id, user_id: owner.id, role: "owner")
        session[:user_id] = owner.id

        delete :destroy, {:id => project.to_param}

        expect(response).to redirect_to(projects_path)
        expect(flash[:notice]).to eq("Project was successfully deleted")
      end
    end
    context "when admin" do
      it "allows deletion" do
        session[:user_id] = admin.id

        delete :destroy, {:id => project.to_param}

        expect(response).to redirect_to(projects_path)
        expect(flash[:notice]).to eq("Project was successfully deleted")
      end
    end
  end

end
