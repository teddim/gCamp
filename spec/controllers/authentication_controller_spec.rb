require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do

  let(:user) { create_user}

  describe 'POST #create' do
    context 'when password is invalid' do
      it 'renders the page with error' do
        post :create, session: { email: user.email, password: 'invalid' }
        expect(response).to render_template(:new)
        expect(flash[:error]).to match(/Email \/ Password combination is invalid/)
      end
    end

#not working
    xcontext 'when password is valid' do
      it 'sets the user in the session and redirects them to their projects page' do
        session[:user_id] = user.id = create_user(email: 't@last.com', password: 'test')
        post :create, session: { email: 't@last.com', password: 'test' }
        # expect(controller.current_user).to eq user
        # expect(response).to redirect_to (projects_path)
      end
    end
  end

  describe 'GET #destroy' do
    it 'clears the user session and redirects the user to the home page' do
      session[:user_id] = user.id

      delete :destroy, id: user.id

      expect(response).to redirect_to root_path
      expect(controller.current_user).to eq nil
      expect(flash[:notice]).to match(/You have successfully logged out/)

    end
  end
end
