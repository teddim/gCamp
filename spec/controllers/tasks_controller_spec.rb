require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  let(:user) {create_user}
  let(:project) {create_project}
  let(:task) {create_task(project_id: project.id)}
  let(:membership) {create_member(user_id: user.id, project_id: project.id, role: "member")}
  let(:owner) {create_user(admin: false, email: 'owner@test.com')}
  let(:member) {create_user(admin: false, email: 'member@test.com')}

  describe "Permissions for Tasks" do
    context 'user belongs to the project' do
      it "shows all tasks" do
        create_member(user_id: member.id, project_id: project.id, role: "member")
        session[:user_id] = member.id

        get :index, {:id => task.id, :project_id => project.id}

        expect(assigns(:tasks)).to eq(Task.all.order(:id))
        expect(response).to render_template(:index)
      end
    end

    context 'user does not belong to the project' do
      it "does not show the tasks" do
        user2 =  create_user(admin: false, email: 'tester2@test.com')
        session[:user_id] = user2.id

        get :index, {:id => task.id, :project_id => project.id}

        expect(response).to redirect_to(projects_path)
        expect(flash[:error]).to eq("You do not have access to that project")
      end
    end

    context 'when admin,' do
      it "shows the tasks" do
        session[:user_id] = user.id

        get :index, {:id => task.id, :project_id => project.id}

        expect(assigns(:tasks)).to eq(Task.all.order(:id))
        expect(response).to render_template(:index)
      end
    end
  end
end
