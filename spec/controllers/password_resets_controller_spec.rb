require 'rails_helper'

describe PasswordResetsController do
  describe 'GET show' do
    it "renders the show template" do
      get :show, id: '123'
      expect(response).to render_template :show
    end
  end

  describe 'POST create' do
    context "with a valid token" do
      before do
        @user = User.new(id: 1, password: 'password', token: '123')
        expect(@user).to receive(:save)
        expect(User).to receive(:where).and_return([@user])
        post :create, id: @user.token
      end

      it "redirects to the root path" do
        expect(response).to redirect_to root_path
      end

      it "logs in the user" do
        expect(session[:user_id]).to eq(@user.id)
      end

      it "sets the user's encrypted password" do
        expect(@user.authenticate('password')).to eq(true)
      end

      it "generates a new token" do
        expect(@user.token).not_to eq('123')
      end
    end
  end

  context "with an invalid token" do
    it "redirects to the root path" do
      post :create, id: 'not_a_token'
      expect(response).to redirect_to root_path
    end
  end
end