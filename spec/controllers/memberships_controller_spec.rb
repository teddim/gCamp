require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do

  let(:user) {create_user(admin: false, email: 'user@test.com')}
  let(:project) {create_project}
  let(:membership) {create_member(user_id: user.id, project_id: project.id, role: "member")}
  let(:owner) {create_user(admin: false, email: 'owner@test.com')}
  let(:admin) {create_user(admin: true, email: 'admin@test.com')}

  describe "GET #index" do
    context 'when member' do
      it "shows all memberships" do
        session[:user_id] = user.id

        get :index, {id: membership.id, project_id: project.id}


        expect(assigns(:membership)).to be_a_new(Membership)
        expect(assigns(:memberships)).to eq(project.memberships.all.order(:role))

        expect(response).to render_template(:index)
      end
    end

    context 'when admin' do
      it "shows all memberships" do
        session[:user_id] = admin.id

        get :index, {id: membership.id, project_id: project.id}


        expect(assigns(:membership)).to be_a_new(Membership)
        expect(assigns(:memberships)).to eq(project.memberships.all.order(:role))

        expect(response).to render_template(:index)
      end
    end

    context 'when not a member' do
      it "will not show memberships" do
        user2 =  create_user(admin: false, email: 'tester2@test.com')
        session[:user_id] = user2.id

        get :index, {id: membership.id, project_id: project.id}

        expect(response).to redirect_to(projects_path)
        expect(flash[:error]).to eq("You do not have access to that project")
      end
    end
  end

  describe "POST #create" do
    context "when admin" do
      it "allows a membership to be created" do
        session[:user_id] = admin.id

        post :create, {project_id:(project.id), membership: {user_id: user.id, role: "member" }}

        expect(response).to have_http_status(302)
        expect(flash[:notice]).to eq("#{user.full_name} was successfully added")
      end
    end

    context "when owner" do
      it "allows a membership to be created" do
        create_member(project_id: project.id, user_id: owner.id, role: "owner")
        session[:user_id] = owner.id

        post :create, {project_id:(project.id), membership: {user_id: user.id, role: "member" }}

        expect(response).to have_http_status(302)
        expect(flash[:notice]).to eq("#{user.full_name} was successfully added")
      end
    end

    context "when a member" do
      it "does not allow a membership to be created" do
        user2 =  create_user(admin: false, email: 'tester2@test.com')
        create_member(project_id: project.id, user_id: user2.id, role: "member")
        session[:user_id] = user2.id

        post :create, {project_id:(project.id), membership: {user_id: user.id, role: "member" }}

        expect(response).to redirect_to(project_memberships_path(project))
      end
    end

    context "when not a member" do
      it "does not allow a membership to be created" do
        user2 =  create_user(admin: false, email: 'tester2@test.com')

        session[:user_id] = user2.id

        post :create, {project_id:(project.id), membership: {user_id: user.id, role: "member" }}

        expect(response).to redirect_to(projects_path)
      end
    end
  end

  describe "POST #update" do
    context "when admin" do
      it "allows a membership to be updated" do
        session[:user_id] = admin.id
        create_member(project_id: project.id, user_id: owner.id, role: "owner")

        post :update, {project_id: project.id, id: membership.to_param, membership: { role: "member" }}

        expect(response).to have_http_status(302)
        expect(flash[:notice]).to eq("#{user.full_name} was successfully updated")
      end
    end

    context "when owner" do
      it "allows a membership to be updated" do
        create_member(project_id: project.id, user_id: owner.id, role: "owner")
        session[:user_id] = owner.id

        post :update, {project_id: project.id, id: membership.to_param, membership: { role: "member" }}

        expect(response).to have_http_status(302)
        expect(flash[:notice]).to eq("#{user.full_name} was successfully updated")
      end
    end

    context "when a member" do
      it "does not allow a membership to be updated" do
        user2 =  create_user(admin: false, email: 'tester2@test.com')
        create_member(project_id: project.id, user_id: user2.id, role: "member")
        session[:user_id] = user2.id

        post :update, {project_id: project.id, id: membership.to_param, membership: { role: "member" }}

        expect(response).to redirect_to(project_path(project))
        expect(flash[:error]).to eq("You do not have access")
      end
    end

    context "when not a member" do
      it "does not allow a membership to be updated" do
        user2 =  create_user(admin: false, email: 'tester2@test.com')

        session[:user_id] = user2.id

        post :create, {project_id:(project.id), membership: {user_id: user.id, role: "member" }}

        expect(response).to redirect_to(projects_path)
      end
    end
  end

  describe "DELETE destroy" do
    context "when admin" do
      it "allows a membership to be deleted" do
        session[:user_id] = admin.id
        create_member(project_id: project.id, user_id: admin.id, role: "owner")
        # create_member(project_id: project.id, user_id: user.id, role: "member")

        delete :destroy, {project_id: project.id, id: membership.to_param}

        expect(response).to have_http_status(302)
        expect(flash[:notice]).to eq("#{user.full_name} was successfully removed")
      end
    end

    context "when owner" do
      it "allows a membership to be deleted" do
        create_member(project_id: project.id, user_id: owner.id, role: "owner")
        session[:user_id] = owner.id

        delete :destroy, {project_id: project.id, id: membership.to_param}

        expect(response).to have_http_status(302)
        expect(flash[:notice]).to eq("#{user.full_name} was successfully removed")
      end
    end

    context "when a member tries to delete someone else's membership" do
      it "does not allow a membership to be deleted" do
        user2 =  create_user(admin: false, email: 'tester2@test.com')
        create_member(project_id: project.id, user_id: user2.id, role: "member")
        create_member(project_id: project.id, user_id: admin.id, role: "owner")
        session[:user_id] = user2.id

        delete :destroy, {project_id: project.id, id: membership.to_param}

        expect(response).to redirect_to(projects_path)
      end
    end

    context "when not a member" do
      it "does not allow a membership to be deleted" do
        user2 =  create_user(admin: false, email: 'tester2@test.com')
        session[:user_id] = user2.id

        delete :destroy, {project_id: project.id, id: membership.to_param}

        expect(response).to redirect_to(projects_path)
      end
    end
  end

end
