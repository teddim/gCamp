require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { create_user(first_name: "Member", admin: false, email: 'member@test.com')}
  let(:owner) {create_user(first_name: "Owner", admin: false, email: 'owner@test.com')}
  let(:admin) {create_user(first_name: "Admin", admin: true, email: 'admin@test.com')}


  describe "GET #index" do
    context "when admin," do
      it "shows all users" do
        session[:user_id] = admin.id

        get :index

        expect(assigns(:users)).to eq(User.all.order(:id))
        expect(response).to render_template(:index)
      end
    end
  end

  describe "GET #new" do
    it "allows the user to create a new user" do
      session[:user_id] = user.id

      get :new

      expect(assigns(:user)).to be_a_new(User)
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "allows a user to create" do
      session[:user_id] = user.id

      post :create, {user: {first_name: "Sherlock", last_name: "Holmes", email: "sherlock@test.com", password: "test" }}

      expect(response).to have_http_status(302)
      expect(flash[:notice]).to eq("User was successfully created")
    end
  end

  describe "GET #show" do
    it "shows the user show page of a user that is not current user" do
      user2 =  create_user(admin: false, email: 'tester2@test.com')
      session[:user_id] = user2.id

      get :show, id: user.id

      expect(assigns(:user)).to eq(user)
      expect(response).to render_template(:show)
    end
  end

  describe "GET #edit" do
    context "when current user tries to edit themselves" do
      it "allows editing" do
        session[:user_id] = user.id

        get :edit, id: user.id

        expect(assigns(:user)).to eq(User.find(user.id))
        expect(response).to render_template :edit
      end
    end

    context "when current user tries to edit someone else" do
      it "does not allow editing" do
        user2 =  create_user(admin: false, email: 'tester2@test.com')
        session[:user_id] = user2.id

        get :edit, id: user.id

        expect(response).to have_http_status(404)
      end
    end

    context "when admin tries to edit someone," do
      it "allows editing" do

        session[:user_id] = admin.id

        get :edit, id: user.id

        expect(response).to have_http_status(200)

      end
    end
  end

  describe "POST #update" do
    context "when a non-admin tries to update another user" do
      it "does not allow it" do
        user2 =  create_user(admin: false, email: 'tester2@test.com')
        session[:user_id] = user2.id

        post :update, {id: user.to_param, user: { first_name: "new name" }}

        expect(response).to redirect_to(users_path)
      end
    end

    context "when a user updates their own record," do
      it "updates the user" do

        session[:user_id] = user.id

        post :update, {id: user.to_param, user: { first_name: "new name" }}

        expect(flash[:notice]).to eq("User was successfully updated")
        expect(response).to redirect_to(users_path)
      end
    end

    context "when admin," do
      it "updates the user" do
        session[:user_id] = admin.id

        put :update, {id: user.to_param, user: { first_name: "new name" }}

        expect(flash[:notice]).to eq("User was successfully updated")
        expect(response).to redirect_to(users_path)
      end
    end
  end

  describe "DELETE destroy" do
    context "when user" do
      it "does not allow users to delete other users' records" do
        user2 =  create_user(admin: false, email: 'tester2@test.com')
        session[:user_id] = user2.id

        delete :destroy, {id: user.to_param}

        expect(response).to redirect_to(root_path)
      end
    end

    context "when user tries to delete their own record" do
      it "allows deletion" do
        session[:user_id] = owner.id

        delete :destroy, {id: user.to_param}

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("User was successfully deleted")
      end
    end

    context "when admin" do
      it "allows deletion" do
        session[:user_id] = admin.id

        delete :destroy, {id: user.to_param}

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("User was successfully deleted")
      end
    end
  end

end
